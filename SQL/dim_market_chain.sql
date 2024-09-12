SELECT
    id_market_chain,
    company,
    Headquarters AS headquarters,
    Served_countries AS served_countries,
    Number_of_locations AS   number_of_locations,
Number_of_employees AS number_of_employees


 FROM `id-superstore.datos_superstore.chains_competitors`  Order by id_market_chain