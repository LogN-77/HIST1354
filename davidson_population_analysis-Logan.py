
import pandas as pd
import matplotlib.pyplot as plt

# Load the provided CSV files
census_data = pd.read_csv('/mnt/data/census_data.csv')
county_codes = pd.read_csv('/mnt/data/county_codes.csv')

# Replace spaces in column names with underscores
county_codes.columns = county_codes.columns.str.replace(" ", "_")

# Filter for Davidson County in Tennessee
davidson_county_info = county_codes[(county_codes['State'] == 'Tennessee') &
                                    (county_codes['County'] == 'Davidson')]

state_code = davidson_county_info.iloc[0]['STATEICP']
county_code = davidson_county_info.iloc[0]['County_cod']

# Filter census data for Davidson County from 1820 to 1840
davidson_census = census_data[(census_data['stateicp'] == state_code) &
                              (census_data['county'] == county_code) &
                              (census_data['year'].isin([1820, 1830, 1840]))]

# Summarize total population by year
davidson_census_summary = davidson_census.groupby('year', as_index=False)['ntotal'].sum()

# Print the summary
print(davidson_census_summary)

# Plot the data
plt.figure(figsize=(8, 5))
plt.plot(davidson_census_summary['year'], davidson_census_summary['ntotal'], marker='o', linestyle='-')
plt.title('Population of Davidson County (1820-1840)')
plt.xlabel('Year')
plt.ylabel('Total Population')
plt.grid(True)
plt.show()
