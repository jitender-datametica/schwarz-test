create or replace volatile table _dedup0 as (
select *
from dbp_etl.marktbestand_erp_zbi_mard_1
);

create or replace volatile table _dedup1 as (
select a.*
from dbp_etl.marktbestand_erp_zbi_mard_1 a
where mandant_id = 1 and
      dat <> cast(td_insert as date)-1 and
      cast(td_insert as time) < '06:00:00'
qualify row_number() OVER (PARTITION BY mandant_id,art_id,wup_id,nb_id,dat 
                           ORDER BY mandant_id,art_id,wup_id,nb_id,dat,laeda desc, uzeit desc, td_insert desc,menge_lgbest_erp_frei_bme,menge_lgbest_erp_qual_bme) = 1
);

delete from _dedup0
where (mandant_id,art_id,wup_id,nb_id,dat,td_insert) in (select mandant_id,art_id,wup_id,nb_id,dat,td_insert from _dedup1)
;

update _dedup1 set dat = dat-1
;

insert into _dedup0
select *
from _dedup1
;

create or replace volatile table _dedup as (
select a.*, (select distinct UPDATE_MODE from ${TEMP_TABLE}) as UPDATE_MODE
from _dedup0 a
qualify row_number() OVER (PARTITION BY mandant_id,art_id,wup_id,nb_id,dat 
                           ORDER BY mandant_id,art_id,wup_id,nb_id,dat,laeda desc, uzeit desc, td_insert desc,menge_lgbest_erp_frei_bme,menge_lgbest_erp_qual_bme) = 1
);

DELETE FROM DBP_DATA.marktbestand_erp_1
WHERE (mandant_id,art_id,wup_id,dat) IN (SELECT mandant_id,art_id,wup_id,dat FROM _dedup)
;

INSERT INTO DBP_DATA.marktbestand_erp_1 (mandant_id
                                      ,art_id
                                      ,wup_id
                                      ,nb_id
                                      ,dat
                                      ,bestand_id
                                      ,bezugsweg_id
                                      ,relevant_fg
                                      ,menge_lgbest_erp_frei_bme
                                      ,menge_lgbest_erp_qual_bme
                                      ,menge_lgbest_erp_gesp_bme
                                      ,fortschreibung_fg
                                      ,td_insert
                                      ,td_update)
SELECT mandant_id
      ,art_id
      ,wup_id
      ,nb_id
      ,dat
      ,bestand_id
      ,bezugsweg_id
      ,relevant_fg
      ,menge_lgbest_erp_frei_bme
      ,menge_lgbest_erp_qual_bme
      ,menge_lgbest_erp_gesp_bme
      ,fortschreibung_fg
      ,td_insert
      ,td_update 
FROM _dedup
;

-- copied from previous version of postsql_script
CREATE or REPLACE TABLE DBP_ETL.marktbestand_erp_temp_1
AS SELECT 
 MANDANT_ID                 
 ,ART_ID                     
 ,WUP_ID                     
 ,NB_ID                      
 ,DAT                        
 ,BESTAND_ID                 
 ,BEZUGSWEG_ID               
 ,RELEVANT_FG                
 ,MENGE_LGBEST_ERP_FREI_BME  
 ,MENGE_LGBEST_ERP_QUAL_BME
 ,MENGE_LGBEST_ERP_GESP_BME  
 ,FORTSCHREIBUNG_FG          
 ,TD_INSERT                  
 ,TD_UPDATE                  
 ,UPDATE_MODE                
FROM _dedup
;
