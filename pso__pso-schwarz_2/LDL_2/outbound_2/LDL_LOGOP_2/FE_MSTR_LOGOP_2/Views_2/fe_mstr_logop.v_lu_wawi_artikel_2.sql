CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_wawi_artikel_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), artikelnr OPTIONS(description='Item_2 nr'),
bez_lang OPTIONS(description='Item_2 description - long'), bez_kurz OPTIONS(description='Item_2 description - short'),
deutschtext OPTIONS(description='Item_2 description - DE'), artgrupnr OPTIONS(description='Item_2 group nr'), artgrupbez
OPTIONS(description='Item_2 group description - DE'), artgrupbez_en OPTIONS(description='Item_2 group description - EN'),
lptyp OPTIONS(description='Storage Type - DE'), lptyp_en OPTIONS(description='Storage Type - EN'), autodispo_flg
OPTIONS(description='Is it relevant for AutoDispo: Yes/No'), wgi OPTIONS(description='Storage Type - DE'), wgi_en
OPTIONS(description='Storage Type - EN'), dwh_load_id OPTIONS(description='Load id'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `ARTIKEL_2 - LOOKUP VIEW BASED ON T_WAWI_ARTIKEL_2 AND T_WAWI_ARTIKELGRP_MAPPING_2`) AS SELECT ART.client_id
 ,
 ART.artikelnr,
 ART.bez_lang,
 ART.bez_kurz,
 ART.deutschtext,
 ATM.artgrupnr,
 ATM.artgrupbez,
 ATM.artgrupbez_en,
 ATM.lptyp,
 ATM.lptyp_en,
 ATM.autodispo_flg,
 ATM.wgi,
 ATM.wgi_en,
 ART.dwh_load_id,
 ART.dwh_created,
 ART.dwh_updated,
 ART.dwh_valid_from,
 ART.dwh_valid_to,
 ART.deleted_fg
FROM ldl_logop_fe_mstr_logop.v_wawi_artikel_2 AS ART_2
 INNER JOIN ldl_logop_fe_mstr_logop.v_lu_wawi_artikelgrp_2 AS ATM ON ART.artgrupnr = ATM.artgrupnr;