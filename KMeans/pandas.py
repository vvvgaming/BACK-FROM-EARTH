pandas.read_sql_table(table_name,con,schema=None,index_col=None,coerce_float=True,
columns=None)
pandas.read_sql_Query(sql, con, index_col=None, coerce_float=True)
pandas.read_sql(sql, con, index_col=None, coerce_float=True, columns=None)

import pandas as pd
formlist = pd.read_sql_query('show table', con = engine)
print('testdb'','\n',formlist)

import pandas as pd
import numpy as ny
df = pd.read_csv("/Users/Will/Downloads/test_assets.csv")

df.dtypes
df.to_csv("/Users/Will/Downloads/test_assets.csv",index=False)
merged = pd.merge(w1, w2)

merged = pd.merge(w1,w2)
merged_all = pd.merge(merged,w3,left_on="name",right_on="merchant_id")

qn = pd.DataFrame(columns=('BIN', 'Boro Code', 'Boro', 'House Number', 'Street Name', 'Address', 'Latitude', 'Longitude'))


df = df.T
pd.set_option('chained_assignment', None)
geoCodeCheck = geoCodeCheck[geoCode['Street Name'] == 'knickerbocker avenue']

mask = (dfList['XCoord'] >= xy2[0]) & (dfList['YCoord'] <= xy1[0])
dfList_subset = dfList.loc[mask]

df2 = df[df2.Address.str.contains("WEST END AVE") == False]
df = df[(df['closing_price'] >= 99) & (df['closig_price'] <= 101)]

df = df[df['Name'].isin(nameList)]
dpsub = dp[~dp['BIN'].isin(binList)]

df2 = df[df['INSPECTION_ID'] == df["INSPECTION_ID.1"]]
only_gold = df[df['Gold'] > 0]

export = export.sort_values(by = 'High Risk Ranking',ascending = False).reset_index(drop = False)
sorted(ratio_list, reverse = True)

ids = dfInt["NODEID"]
dfInt2 = dfInt[ids.isin(ids[ids.duplicated()])].sort_values(by = "NODEID")

ratio_list = sorted(ratio_list, key = itemgetter(1), reverse = True)
df = df.reindex_axis(sorted(columns),axis = 1)

df = pd.DataFrame(dfList, columns = ['BIN', 'Boro', 'Address'])
list_block = []
for i in range(0, len(df2)):
    list_block.append(df2["Block"][i])

dateList = df2['Date'].tolist()
set_block = set(list_block)

text = [x for x in text if not any(c.isdigit() for c in x)]
set_block = sorted(set_block)

frame = pd.DataFrame({'a':['the cat is blue','the sky is green','the dog is black']})
mylist = ['dog','cat','fish']

pattern = '|'.join(mylist)
frame["TF"] = frame.a.str.contains(pattern)

a = filter(None,a)
a = [1,"",3,1,3,2,1,1]

a = ["NA" if x == "" else x for x in a]
x = list(set(list1).intersection(list2))

words = flist
final_string = ','.join(str(nameDic.get(word,word)) for word in words)

matchList.sort(key = lambda s:len(s),reverse = Ture)
name_list = ['ALEX PERA','','VAL TOL']

name_list = [x for x in name_list if x != '']
oList = sum(oList,[])

people = ['Dr.Christopher Brooks', 'Dr.Kevyn Collins-Thompson', 'Dr. VG Vinod Vydiswaran', 'Dr.Daneil Romaro']
def split_title_and_name(person)

list(map(split_title_and_name, people))
df3['Target'] = df.WAITING_TIME.map(lambda x: 1 if x >= 1800 else 0)

my_function = lamda a,b,c:a3 + b2 + c
print my_function(2,3,4)

df = df[["Permit Number","PermitType"]]
jobtype_dummies = pd.get_dummies(df.PermitType, prefix = 'PermitType')

df = pd.concat([df,jobtype_dummies], axis = 1)
lst = []

for i in range(10)
lst = [i * j for in range(10) for j in range(10)]

all_data = pd.DataFrame()
all_data = all_data.append(df, ignore_index = False)

location_df = df['h_no'].apply(lambda x:pd.Series(x.split(',')))
common_cols = list(set(df14.Address) & set(dfmn.Address))

dfmn["Corner"] = 0
for i in range(0, len(dfmn))

lv['Correct Duration Sum'] = lv['Correct Duration'].groupby(v['CityTime ID']).transform('sum')
qnG = qn.groupby(['BIN','Year']).sum()

qnG = qnG.add_suffix('_Count').reset_index()
dfG = df.groupby('Category').apply(lambda df,a,b: sum(df[a] * df[b]), 'Weight (oz.)', 'Quantity'))

dfG = (df.groupby('BIN_Number').agg({'Job_Number':'count', 'AHV_Grants': 'sum', 'Initial_Da':'sum', 'Additional':'sum'}).reset_index().rename(columns={'Job_Number':'Job_Number_count'}) )
df3 = df.groupby("Date").agg({"VISIT_KEY": pd.Series.nunique})

f = rank_title.groupby('Name')['Title'].apply(lambda x: "{%s}" % ', '.join(x))
X = pd.DataFrame(f)

X = X.reset_index(drop = False)
coG = coG.groupby(['BIN Number'], sort=False)['C of O Issue Date'].max()

df['DATA_SCHEDULED'] = pd.to_datetime(df['DATE_SCHEDULED'])
star_date = str(1) + '-' + str(1) + '-' + str(2019)

from dateutil import parser
star_date = parser.parser(star_date)

star_date = star_date.date()
db["DATE_INSPECTION"] = db["DATE_INSPECTION"].apply(lambda x: x.date())

df['Inspection Time'] = df["Inspection Time"].apply(lamda d : d.time())
df['Difference'] = (df["hearing_date"] - df["ticket_issued_date"]).dt.days

d = df2["Variance End Date"][j] - df2["Variance Start Date"][j]
diff = d.days
diff = int(diff)

print pd.Timedelta(d["Next_Login"][0] - d["Crash_Time_EST"][0]).seconds / 3600.0
df2 = df2.assign(session = pd.cut(df2.DateTime.dt.hour,[0,6,12,18,24], labels = ['Night','Morning','Afternoon','Evening']))

df["Week Number"][i] = datetime.date(year,month,day).isocalendar()[1]
star_time = str(lv["Star Time"][i].month) + '-' + str(lv["Star Time"][i].day) + '-' + str(lv["Star Time"][i].year)

end_time = str(lv["End Time"][i].month) + '-' + str(lv["End Time"][i].day) + '-' + str(lv["End Time"][i].year)
mask = (wd['workdays'] >= star_time) & (wd['workdays'] <= end_time)

wd_subset = wd.loc[mask]
from datetime import datetime

print str(datetime.now())
insp_date = df["DATE_INSPCTION"][0]

d = datetime.timedelta(days = 2)
minus2 = insp_date - d

plus2 = insp_date + d
mask = (all_data2['Date'] >= minus2) & (all_data2['Date'] <= plus2)

dfpm2 = all_data2.loc[mask]
sum_trans = df3["Transaction Amount"].sum()

df2["EucDistance"].min()
df.describe().transpose()

dr.dtypes
dr[dr.select_dtypes(include = ['float']).columns] *= 100

dr = dr.round(2)
dwsDic = dwsG.set_index('bin')['WallArea SqFt'].to_dict()

df["lat"] = df["address"].map(lat)
di = {1: "A", 2: "B"}

df = df.replace({"col1": di})
dic_s = {'7398378':'Y','7398310':'Y'}

df['Flag'] = df['Job Number'].map(dic_s).fillna('N')
for i in range(0, len(dfdn)):
     print "terracot address", dfdn["AddressMatch"][i]
try: 
    print "dic list", d2[dfdn["AddressMatch"][i]] 
except KeyError, e:
    print e

import pandas as pd
import numpy as np
data = pd.read_csv("train.csv", index_col = "loan_ID")

#Create a new function:

def num_missing(x):
    return sum(x.isnull())


#Applying per column:
print "Mis"