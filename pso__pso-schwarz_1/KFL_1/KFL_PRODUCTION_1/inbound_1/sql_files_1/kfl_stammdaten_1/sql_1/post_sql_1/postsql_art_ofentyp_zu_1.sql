DELETE FROM  dbp_data.art_ofentyp_zu_1 t1_1
WHERE EXISTS (SELECT * 
              FROM ${TEMP_TABLE} t2  /*dbp_etl.art_ofentyp_zu_temp*/
              WHERE t1.art_id = t2.art_id AND 
                    t1.mandant_id = t2.mandant_id AND 
                    TRIM(t1.ofen_typ_id) = t2.ofen_typ_id AND  /* TRIM added for S4HANA prj because of E env state */
                    t2.blech_belegung <> 0)
;

INSERT INTO dbp_data.art_ofentyp_zu_1 
 (
        art_id
        ,mandant_id
        ,ofen_typ_id
        ,blech_belegung
        ,td_insert
        ,td_update
 )
 SELECT 
      art_id
      ,mandant_id
      ,ofen_typ_id
      ,blech_belegung
      ,td_insert
      ,td_update
 FROM ${TEMP_TABLE} /*dbp_etl.art_ofentyp_zu_temp*/
 WHERE blech_belegung <> 0
 ;
