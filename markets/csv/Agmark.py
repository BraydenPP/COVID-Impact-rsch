print('file found')
import requests
import lxml.html
import csv

results = []
Commodity = ['Ajwan', 'Alasande Gram', 'Almond(Badam)', 'Alsandikai', 'Amaranthus', 'Ambada Seed', 'Amla(Nelli Kai)', 'Amphophalus', 'Anthar (Tur/Red Gram)(awala', 'Anthorium', 'Apple', 'Apricot(Jardalu/Khumani)', 'Arecanut(Betelnut/Supari)', 'ArWhole)', 'Arhar Dal(Tur Dal)', 'Ashgourd', 'Astera', 'Avare Dal', 'Bajra(Pearl Millet/Cumbu)', 'Balekai', 'Bamboo', 'Banana', 'Banana - Green', 'Barley (Jau)', 'Bay leaf (Tejpatta)', 'Beans', 'Beaten Rice', 'Beetroot', 'Bengal Gram Dal (Chana Dal)', 'Bengal Gram(Gram)(Whole)', 'Ber(Zizyphus/Borehannu)', 'Betal Leaves', 'Betelnuts', 'Bhindi(Ladies Finger)', 'Big Gram', 'Binoula', 'Bitter gourd', 'Black Gram (Urd Beans)(Whole)', 'Black Gram Dal (Urd Dal)', 'Black pepper', 'BOP', 'Borehannu', 'Bottle gourd', 'Bran', 'Brinjal', 'Broken Rice', 'Broomstick(Flower Broom)', 'Bull', 'Bullar', 'Bunch Beans', 'Butter', 'Cabbage', 'Calf', 'Camel Hair', 'Cane', 'Capsicum', 'Cardamoms', 'Carnation', 'Carrot', 'Cashew Kernnel', 'Cashewnuts', 'Cashewnuts', 'Castor Oil', 'Castor Seed', 'Cauliflower', 'Chakotha', 'Chapparad Avare', 'Chennangi (Whole)', 'Chennangi Dal', 'Cherry', 'Chikoos(Sapota)', 'Chili Red', 'Chilly Capsicum', 'Chow Chow', 'Chrysanthemum', 'Chrysanthemum(Loose)', 'Cinamon(Dalchini)', 'Cloves', 'Cluster beans', 'Coca', 'Cock', 'Cocoa', 'Coconut', 'Coconut', 'Coconut Oil', 'Coconut Seed', 'Coffee', 'Colacasia', 'Copra', 'Coriander(Leaves)', 'Corriander seed', 'Cotton', 'Cotton Seed', 'Cow', 'Cowpea (Lobia/Karamani)', 'Cowpea(Veg)', 'Cucumbar(Kheera)', 'Cummin Seed(Jeera)', 'Custard Apple (Sharifa)', 'Daila(Chandni)', 'Dal (Avare)', 'Dalda', 'Delha', 'Dhaincha', 'Drumstick', 'Dry Chillies', 'Dry Fodder', 'Dry Grapes', 'Duck', 'Duster Beans', 'Egg', 'Egypian Clover(Barseem)', 'Elephant Yam (Suran)', 'Field Pea', 'Fig(Anjura/Anjeer)', 'Firewood', 'Fish', 'Flower Broom', 'Foxtail Millet(Navane)', 'French Beans (Frasbean)', 'Galgal(Lemon)', 'Garlic', 'Ghee', 'Gingelly Oil', 'Ginger(Dry)', 'Ginger(Green)', 'Gladiolus Bulb', 'Gladiolus Cut Flower', 'Goat', 'Goat Hair', 'Gram Raw(Chholia)', 'Gramflour', 'Grapes', 'Green Avare (W)', 'Green Chilli', 'Green Fodder', 'Green Gram (Moong)(Whole)', 'Green Gram Dal (Moong Dal)', 'Green Peas', 'Ground Nut Oil', 'Ground Nut Seed', 'Groundnut', 'Groundnut (Split)', 'Groundnut pods (raw)', 'Guar', 'Guar Seed(Cluster Beans Seed)', 'Guava', 'Gur(Jaggery)', 'Gurellu', 'Haralekai', 'He Buffalo', 'Hen', 'Hippe Seed', 'Honey', 'Honge seed', 'Hybrid Cumbu', 'Indian Beans (Seam)', 'Indian Colza(Sarson)', 'Isabgul (Psyllium)', 'Jack Fruit', 'Jaffri', 'Jaggery', 'Jamamkhan', 'Jamun(Narale Hannu)', 'Jarbara', 'Jasmine', 'Javi', 'Jowar(Sorghum)', 'Jute', 'Jute Seed', 'Kabuli Chana(Chickpeas-White)', 'Kacholam', 'Kakada', 'Kankambra', 'Karamani', 'Karbuja(Musk Melon)', 'Kartali (Kantola)', 'Kharif Mash', 'Khoya', 'Kinnow', 'Knool Khol', 'Kodo Millet(Varagu)', 'Kuchur', 'Kulthi(Horse Gram)', 'Ladies Finger', 'Lak(Teora)', 'Leafy Vegetable', 'Lemon', 'Lentil (Masur)(Whole)', 'Lilly', 'Lime', 'Linseed', 'Lint', 'Litchi', 'Little gourd (Kundru)', 'Long Melon(Kakri)', 'Lotus', 'Lotus Sticks', 'Lukad', 'Mace', 'Mahedi', 'Mahua', 'Mahua Seed(Hippe seed)', 'Maida Atta', 'Maize', 'Mango', 'Mango (Raw-Ripe)', 'Maragensu', 'Marasebu', 'Marget', 'Marigold(Calcutta)', 'Marigold(loose)', 'Mash', 'Mashrooms', 'Masur Dal', 'Mataki', 'Methi Seeds', 'Methi(Leaves)', 'Millets', 'Mint(Pudina)', 'Moath Dal', 'Moath Dal', 'Mousambi(Sweet Lime)', 'Mustard', 'Mustard Oil', 'Myrobolan(Harad)', 'Nargasi', 'Nearle Hannu', 'Neem Seed', 'Nelli Kai', 'Niger Seed (Ramtil)', 'Nutmeg', 'Onion', 'Onion Green', 'Orange', 'Orchid', 'Other Pulses', 'Ox', 'Paddy(Dhan)(Basmati)', 'Paddy(Dhan)(Common)', 'Papaya', 'Papaya (Raw)', 'Patti Calcutta', 'Peach', 'Pear(Marasebu)', 'Peas cod', 'Peas Wet', 'Peas(Dry)', 'Pegeon Pea (Arhar Fali)', 'Pepper garbled', 'Pepper ungarbled', 'Persimon(Japani Fal)', 'Pigs', 'Pineapple', 'Plum', 'Pointed gourd (Parval)', 'Polherb', 'Pomegranate', 'Potato', 'Pumpkin', 'Pundi', 'Pundi Seed', 'Raddish', 'Ragi (Finger Millet)', 'Raibel', 'Rajgir', 'Ram', 'Rat Tail Radish (Mogari)', 'Raya', 'Red Gram', 'Resinwood', 'Riccbcan', 'Rice', 'Ridge gourd(Tori)', 'Rose(Local)', 'Rose(Loose)', 'Rose(Tata)', 'Round gourd', 'Rubber', 'Sabu Dana', 'Safflower', 'Saffron', 'Sajje', 'Same/Savi', 'Sarasum', 'Season Leaves', 'Seegu', 'Seemebadnekai', 'Seetafal', 'Sesamum(Sesame,Gingelly,Til)', 'She Buffalo', 'She Goat', 'Sheep', 'Siddota', 'Skin And Hide', 'Snake gourd', 'Soanf', 'Soapnut(Antawala/Retha)', 'Soji', 'Sompu', 'Soyabean', 'Spinach', 'Sponge gourd', 'Squash(Chappal Kadoo)', 'Sugar', 'Sugarcane', 'Sunflower', 'Sunflower Seed', 'Sunhemp', 'Suram', 'Surat Beans (Papadi)', 'Suva (Dill Seed)', 'Suvarna Gadde', 'Sweet Potato', 'Sweet Pumpkin', 'T.V. Cumbu', 'Tamarind Fruit', 'Tamarind Seed', 'Tapioca', 'Taramira', 'Tea', 'Tender Coconut', 'Thinai (Italian Millet)', 'Thogrikai', 'Thondekai', 'Tinda', 'Tobacco', 'Tomato', 'Torchwood', 'Toria', 'Tube Flower', 'Tube Rose(Double)', 'Tube Rose(Loose)', 'Tube Rose(Single)', 'Turmeric', 'Turmeric (raw)', 'Turnip', 'Walnut', 'Water Melon', 'Wheat', 'Wheat Atta', 'White Peas', 'White Pumpkin', 'Wood', 'Wool', 'Yam', 'Yam (Ratalu)']
header = ['state', 'district', 'mandi', 'group', 'qty', 'modeprice', 'date']

# !!!!!!!!!!!!!!!
# checklist prior to run:
# change M (month) range
# change Y (year) range

for Y in range(2017, 2018):
    for M in range(2, 5):
        if M == 2 and Y != 2016:
            for D in range(1, 29):
                for i in Commodity:
                    html = requests.get(
                        f'https://agmarknet.gov.in/SearchCmmMkt.aspx?Tx_Commodity=1&Tx_State=0&Tx_District=0&Tx_Market'
                        f'=0&DateFrom={M}%2f{D}%2f{Y}&DateTo=31-Dec-2020&Fr_Date=1%2f1%2f2016&To_Date=31-Dec-2020&Tx_Trend='
                        f'2&Tx_CommodityHead={i}&Tx_StateHead=--Select--&Tx_DistrictHead=--Select--&Tx_MarketHead=--Select--')
                    doc = lxml.html.fromstring(html.content)
                    tr = doc.xpath('//*[@id="cphBody_GridViewBoth"]/tr')
                    for td in tr:
                        state = td.xpath('./td[1]/text()')
                        district = td.xpath('./td[2]/text()')
                        mandi = td.xpath('./td[3]/text()')
                        group = td.xpath('./td[5]/text()')
                        qty = td.xpath('./td[6]/text()')
                        modeprice = td.xpath('./td[9]/text()')
                        date = td.xpath('./td[10]/text()')
                        for data in zip(state, district, mandi, group, qty, modeprice, date):
                            resp = {'state': data[0], 'district': data[1], 'mandi': data[2], 'group': data[3],
                                    'qty': data[4], 'modeprice': data[5], 'date': data[6]}
                            results.append(resp)
                print(f'days completed: {D}')
            print(f'months completed: {M}')
            with open(f'//rschfs1x/userrs/a-e/bp257_RS/Desktop/data/markets/csv/{Y}m{M}.csv', 'w',
                newline='') as csvfile:
                writer = csv.DictWriter(csvfile, fieldnames=header)
                writer.writeheader()
                writer.writerows(results)
            results = []
        if M == 2 and Y == 2016:
            for D in range(1, 30):
                for i in Commodity:
                    html = requests.get(
                        f'https://agmarknet.gov.in/SearchCmmMkt.aspx?Tx_Commodity=1&Tx_State=0&Tx_District=0&Tx_Market'
                        f'=0&DateFrom={M}%2f{D}%2f{Y}&DateTo=31-Dec-2020&Fr_Date=1%2f1%2f2016&To_Date=31-Dec-2020&Tx_Trend='
                        f'2&Tx_CommodityHead={i}&Tx_StateHead=--Select--&Tx_DistrictHead=--Select--&Tx_MarketHead=--Select--')
                    doc = lxml.html.fromstring(html.content)
                    tr = doc.xpath('//*[@id="cphBody_GridViewBoth"]/tr')
                    for td in tr:
                        state = td.xpath('./td[1]/text()')
                        district = td.xpath('./td[2]/text()')
                        mandi = td.xpath('./td[3]/text()')
                        group = td.xpath('./td[5]/text()')
                        qty = td.xpath('./td[6]/text()')
                        modeprice = td.xpath('./td[9]/text()')
                        date = td.xpath('./td[10]/text()')
                        for data in zip(state, district, mandi, group, qty, modeprice, date):
                            resp = {'state': data[0], 'district': data[1], 'mandi': data[2], 'group': data[3],
                                    'qty': data[4], 'modeprice': data[5], 'date': data[6]}
                            results.append(resp)
                print(f'days completed: {D}')
            print(f'months completed: {M}')
            with open(f'//rschfs1x/userrs/a-e/bp257_RS/Desktop/data/markets/csv/{Y}m{M}.csv', 'w',
                newline='') as csvfile:
                writer = csv.DictWriter(csvfile, fieldnames=header)
                writer.writeheader()
                writer.writerows(results)
            results = []
        if M == 4 or M == 6 or M == 9 or M == 11:
            for D in range(1, 31):
                for i in Commodity:
                    html = requests.get(
                        f'https://agmarknet.gov.in/SearchCmmMkt.aspx?Tx_Commodity=1&Tx_State=0&Tx_District=0&Tx_Market'
                        f'=0&DateFrom={M}%2f{D}%2f{Y}&DateTo=31-Dec-2020&Fr_Date=1%2f1%2f2016&To_Date=31-Dec-2020&Tx_Trend='
                        f'2&Tx_CommodityHead={i}&Tx_StateHead=--Select--&Tx_DistrictHead=--Select--&Tx_MarketHead=--Select--')
                    doc = lxml.html.fromstring(html.content)
                    tr = doc.xpath('//*[@id="cphBody_GridViewBoth"]/tr')
                    for td in tr:
                        state = td.xpath('./td[1]/text()')
                        district = td.xpath('./td[2]/text()')
                        mandi = td.xpath('./td[3]/text()')
                        group = td.xpath('./td[5]/text()')
                        qty = td.xpath('./td[6]/text()')
                        modeprice = td.xpath('./td[9]/text()')
                        date = td.xpath('./td[10]/text()')
                        for data in zip(state, district, mandi, group, qty, modeprice, date):
                            resp = {'state': data[0], 'district': data[1], 'mandi': data[2], 'group': data[3],
                                    'qty': data[4], 'modeprice': data[5], 'date': data[6]}
                            results.append(resp)
                print(f'days completed: {D}')
            print(f'months completed: {M}')
            with open(f'//rschfs1x/userrs/a-e/bp257_RS/Desktop/data/markets/csv/{Y}m{M}.csv', 'w',
                newline='') as csvfile:
                writer = csv.DictWriter(csvfile, fieldnames=header)
                writer.writeheader()
                writer.writerows(results)
            results = []
        else:
            for D in range(1, 32):
                for i in Commodity:
                    html = requests.get(
                        f'https://agmarknet.gov.in/SearchCmmMkt.aspx?Tx_Commodity=1&Tx_State=0&Tx_District=0&Tx_Market'
                        f'=0&DateFrom={M}%2f{D}%2f{Y}&DateTo=31-Dec-2020&Fr_Date=1%2f1%2f2016&To_Date=31-Dec-2020&Tx_Trend='
                        f'2&Tx_CommodityHead={i}&Tx_StateHead=--Select--&Tx_DistrictHead=--Select--&Tx_MarketHead=--Select--')
                    doc = lxml.html.fromstring(html.content)
                    tr = doc.xpath('//*[@id="cphBody_GridViewBoth"]/tr')
                    for td in tr:
                        state = td.xpath('./td[1]/text()')
                        district = td.xpath('./td[2]/text()')
                        mandi = td.xpath('./td[3]/text()')
                        group = td.xpath('./td[5]/text()')
                        qty = td.xpath('./td[6]/text()')
                        modeprice = td.xpath('./td[9]/text()')
                        date = td.xpath('./td[10]/text()')
                        for data in zip(state, district, mandi, group, qty, modeprice, date):
                            resp = {'state': data[0], 'district': data[1], 'mandi': data[2], 'group': data[3],
                                    'qty': data[4], 'modeprice': data[5], 'date': data[6]}
                            results.append(resp)
                print(f'days completed: {D}')
            print(f'months completed: {M}')
            with open(f'//rschfs1x/userrs/a-e/bp257_RS/Desktop/data/markets/csv/{Y}m{M}.csv', 'w',
                newline='') as csvfile:
                writer = csv.DictWriter(csvfile, fieldnames=header)
                writer.writeheader()
                writer.writerows(results)
            results = []
