print('file found')
import requests
import lxml.html
import csv

results = []
commodities = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '12', '13', '15', '16', '17', '18', '19', '20', '21', '22',
               '23', '24', '25', '26', '27', '28', '29', '30', '34', '36', '38', '39', '40', '42', '43', '44', '45',
               '48', '50', '63', '66', '72', '73', '74', '78', '82', '84', '85', '87', '89', '90', '91', '92', '94',
               '97', '99', '103', '113', '129', '132', '138', '152', '153', '154', '155', '156', '157', '158',
               '159', '160', '164', '165', '168', '173', '182', '185', '190', '201', '208', '221', '238', '249', '259',
               '261', '263', '264', '265', '267', '270', '273', '276', '278', '287', '293', '294', '298', '301', '302',
               '303', '304', '306', '309', '310', '311', '313', '314', '324', '330', '331', '332', '341', '343', '345',
               '346', '342', '347', '349', '350', '352', '359', '362', '366', '367', '373', '382', '410', '414', '35', '108']
header = ['state', 'district', 'mandi', 'item', 'group', 'qty', 'modeprice', 'date']


# !!!!!!!!!!!!!!!
# checklist prior to run:
# change M (month) range
# change Y (year) range

def scrape():
    html = requests.get(
        f'https://agmarknet.gov.in/SearchCmmMkt.aspx?Tx_Commodity={i}&Tx_State=0&Tx_District=0&Tx_Market'
        f'=0&DateFrom={M}%2f{D}%2f{Y}&DateTo=31-Dec-2020&Fr_Date=1%2f1%2f2016&To_Date=31-Dec-2020&Tx_Trend='
        f'2&Tx_CommodityHead=--Select--&Tx_StateHead=--Select--&Tx_DistrictHead=--Select--&Tx_MarketHead=--Select--')
    doc = lxml.html.fromstring(html.content)
    tr = doc.xpath('//*[@id="cphBody_GridViewBoth"]/tr')
    for td in tr:
        state = td.xpath('./td[1]/text()')
        district = td.xpath('./td[2]/text()')
        mandi = td.xpath('./td[3]/text()')
        item = doc.xpath('//*[@id="ddlCommodity"]/option[@selected="selected"]/text()')
        group = td.xpath('./td[5]/text()')
        qty = td.xpath('./td[6]/text()')
        modeprice = td.xpath('./td[9]/text()')
        date = td.xpath('./td[10]/text()')
        for data in zip(state, district, mandi, item, group, qty, modeprice, date):
            resp = {'state': data[0], 'district': data[1], 'mandi': data[2], 'item': data[3], 'group': data[4],
                    'qty': data[5], 'modeprice': data[6], 'date': data[7]}
            results.append(resp)


def append():
    with open(f'//rschfs1x/userrs/a-e/bp257_RS/Desktop/data/markets/csv/{Y}m{M}-{D}.csv', 'w',
              newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=header)
        writer.writeheader()
        writer.writerows(results)
    results.clear()


# actual scraping process
print('starting scrape')
for Y in range(2019, 2020):
    for M in range(7, 10):
        if M == 2 and (Y != 2016 and Y != 2020):
            for D in range(1, 29):
                for i in commodities:
                    scrape()
                print(f'days completed: {D}')
                if D == 15 or D == 28:
                    append()
            print(f'months completed: {M}')
        elif M == 2 and (Y == 2016 or Y == 2020):
            for D in range(1, 30):
                for i in commodities:
                    scrape()
                print(f'days completed: {D}')
                if D == 15 or D == 29:
                    append()
            print(f'months completed: {M}')
        elif M == 4 or M == 6 or M == 9 or M == 11:
            for D in range(1, 31):
                for i in commodities:
                    scrape()
                print(f'days completed: {D}')
                if D == 15 or D == 30:
                    append()
            print(f'months completed: {M}')
        else:
            for D in range(1, 32):
                for i in commodities:
                    scrape()
                print(f'days completed: {D}')
                if D == 15 or D == 31:
                    append()
            print(f'months completed: {M}')
