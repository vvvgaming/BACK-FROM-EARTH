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

df2 = df[df2.Addres.str.contains("WEST END AVE") == False]
df = df[(df['closing_price'] >= 99)] 