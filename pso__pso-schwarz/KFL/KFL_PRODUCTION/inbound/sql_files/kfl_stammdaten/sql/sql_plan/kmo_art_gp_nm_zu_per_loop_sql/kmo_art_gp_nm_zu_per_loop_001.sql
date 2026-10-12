UPDATE DBP_ETL.art_gp_nm_zu_per_dat_relevant SET dat_relevant = dat_relevant + 1;

/*** Luecken in der art_gp_verhandlung_zu Tabelle per default Werte schliessen */
INSERT  INTO DBP_DATA.art_gp_verhandlung_zu 
(mandant_id,gp_id, art_id,IVN_GRUPPE_ID,IVN_VERHANDLUNGS_CLUSTER_ID,IVN_SORTIMENTSGRUPPE_ID,QUELLSYSTEM_ID, td_insert)

SELECT a.mandant_id, a.gp_id, a.art_id, -1,-1,-1,1, CURRENT_TIMESTAMP 
  FROM (
        SELECT a.mandant_id, a.gp_id, a.art_id 
          FROM DBP_DATA.art_gp_nm_zu_per a
          LEFT JOIN DBP_DATA.art_gp_verhandlung_zu g
            ON a.mandant_id = g.mandant_id
           AND a.art_id= g.art_id 
           AND a.gp_id= g.gp_id 
         WHERE g.mandant_id is null
           
         GROUP BY 1,2,3
       ) a 
;

