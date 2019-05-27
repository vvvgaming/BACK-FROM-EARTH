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

