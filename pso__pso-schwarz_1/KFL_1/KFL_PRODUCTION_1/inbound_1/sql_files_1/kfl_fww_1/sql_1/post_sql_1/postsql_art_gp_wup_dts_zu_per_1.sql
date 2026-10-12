UPDATE DBP_DATA.art_gp_wup_dts_zu_per_1
SET dat_bis = b.dat_bis_
FROM (SELECT mandant_id AS mandant_id_, wup_id AS wup_id_, art_id AS art_id_,
      MAX(dat_von) AS dat_bis_
      FROM ${TEMP_TABLE} 
      GROUP BY 1,2,3) b
WHERE mandant_id = b.mandant_id_ 
      AND wup_id = b.wup_id_ 
      AND art_id = b.art_id_ 
      AND (mandant_id, wup_id, art_id, gp_id) NOT IN ( SELECT mandant_id, wup_id, art_id, gp_id FROM ${TEMP_TABLE} ) 
      AND dat_bis = '9999-12-31'
;
