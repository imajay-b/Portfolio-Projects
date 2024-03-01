#!/usr/bin/env python
# coding: utf-8

# # Match Summary

# In[1]:


import pandas as pd
import json


# Process match Result

# In[4]:


with open ('/Users/ajayb/Documents/data analysis project/python & pandas/T20 World cup /t20_json_files/t20_wc_match_results.json') as f:
    data = json.load(f)
    
df_match = pd.DataFrame(data[0]['matchSummary'])
df_match.head()


# In[5]:


df_match.shape


# In[7]:


df_match.rename({'scorecard': 'match_id'}, axis = 1,inplace = True)
df_match.head()


# In[8]:


match_ids_dict = {}

for index, row in df_match.iterrows():
    key1 = row['team1'] + ' Vs ' + row['team2']
    key2 = row['team2'] + ' Vs ' + row['team1']
    
    match_ids_dict[key1] = row["match_id"]
    match_ids_dict[key2] = row["match_id"]
    
match_ids_dict


# In[ ]:


{
    "Namibia Vs Sri lanka": "T20I # 1823" ,
    "Sri lanka Vs Namibia": "T20I # 1823" ,
    "Netherlands Vs U.A.E.": "T20I # 1825",
    "U.A.E. Vs Netherlands": "T20I # 1825"
    ...
}    


# In[26]:


df_match.to_csv('/Users/ajayb/Documents/data analysis project/python & pandas/T20 World cup /T20 CSV/match_summary.csv', index = False)


# # Batting Summary

# In[11]:


with open('/Users/ajayb/Documents/data analysis project/python & pandas/T20 World cup /t20_json_files/t20_wc_batting_summary.json') as f:
    data = json.load(f)
    
    all_records = []
    
    for rec in data:
        all_records.extend(rec['battingSummary'])

df_batting = pd.DataFrame(all_records)
df_batting.head(11)


# In[12]:


df_batting["OUT/NOT OUT"]= df_batting.dismissal.apply(lambda x: "OUT" if len(x) > 0 else "NOT_OUT")
df_batting.head()


# In[13]:


df_batting.drop(columns=["dismissal"], inplace=True)
df_batting.head(10)


# In[14]:


df_batting['batsmanName'] = df_batting['batsmanName'].apply(lambda x: x.replace('†', ''))
df_batting['batsmanName'] = df_batting['batsmanName'].apply(lambda x: x.replace('\xa0', ''))
df_batting.head(10)


# In[15]:


df_batting["mach_id"] = df_batting["match"].map(match_ids_dict)

df_batting.head()


# In[27]:


df_batting.to_csv('/Users/ajayb/Documents/data analysis project/python & pandas/T20 World cup /T20 CSV/T20_batting_summary.csv', index = False)


# # Bowling summary

# In[20]:


with open('/Users/ajayb/Documents/data analysis project/python & pandas/T20 World cup /t20_json_files/t20_wc_bowling_summary.json') as f:
    data = json.load(f)
    
    all_records = []
    
    for rec in data:
        all_records.extend(rec['bowlingSummary'])
all_records[:2]


# In[21]:


df_bowling = pd.DataFrame(all_records)
print(df_bowling.shape)
df_bowling.head()


# In[22]:


df_bowling['match_id'] = df_bowling['match'].map(match_ids_dict)
df_bowling.head()


# In[23]:


df_bowling['match_id'] = df_bowling['match'].map(match_ids_dict)
df_bowling.head()


# In[28]:


df_bowling.to_csv('/Users/ajayb/Documents/data analysis project/python & pandas/T20 World cup /T20 CSV/T20_Bowling_summary.csv', index = False)


# # Player Information

# In[29]:


with open('/Users/ajayb/Documents/data analysis project/python & pandas/T20 World cup /t20_json_files/t20_wc_player_info.json') as f:
    data = json.load(f)


# In[30]:


df_players = pd.DataFrame(data)

print(df_players.shape)
df_players.head(10)


# In[ ]:


# cleaning up the character


# In[31]:


df_players['name'] = df_players['name'].apply(lambda x: x.replace('â€', ''))
df_players['name'] = df_players['name'].apply(lambda x: x.replace('†', ''))
df_players['name'] = df_players['name'].apply(lambda x: x.replace('\xa0', ''))
df_players.head(10)


# In[32]:


df_players[df_players['team'] == 'India']


# In[33]:


df_players.to_csv('/Users/ajayb/Documents/data analysis project/python & pandas/T20 World cup /T20 CSV/T20_player_summary.csv', index = False)

