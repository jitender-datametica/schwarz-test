CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_artikelgrp_mapping_1 (
artgrupnr BIGNUMERIC(38,0) OPTIONS(description='Item_1 group nr'),
artgrupbez STRING(100) OPTIONS(description='Item_1 group description - DE'),
artgrupbez_en STRING(100) OPTIONS(description='Item_1 group description - EN'),
lptyp STRING(100) OPTIONS(description='Storage Type - DE'),
lptyp_en STRING(100) OPTIONS(description='Storage Type - EN'),
autodispo_flg STRING(18) OPTIONS(description='Is it relevant for AutoDispo: Yes/No'),
wgi STRING(100) OPTIONS(description='Storage Type - DE'),
wgi_en STRING(100) OPTIONS(description='Storage Type - EN')
) OPTIONS(description='WAWI - Article Group and Storage Type Mapping');