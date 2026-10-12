DROP TABLE IF EXISTS DBP_ETL.art_wup_autodispo_flw_tag_ret_bestand_temp_1;

 
CREATE TABLE DBP_ETL.art_wup_autodispo_flw_tag_ret_bestand_temp_1 
     (
      mandant_id BYTEINT NOT NULL,
      kunde_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id_kunde SMALLINT NOT NULL,
      nb_id_lieferant SMALLINT NOT NULL,
      art_id INTEGER NOT NULL,
      dat DATE  NOT NULL,
      ret_bestand DECIMAL(13,3),
      egalisierungsfaktor DECIMAL(18,7),
      menge_einh_id CHAR(10),
      nullbestand_exc_fg BYTEINT DEFAULT 0
);

/*
#------------------------------------------------------------------------------
# 2) Daten aus dbp_data.art_wup_autodispo_flw_tag_1 holen
#------------------------------------------------------------------------------
*/

INSERT INTO DBP_ETL.art_wup_autodispo_flw_tag_ret_bestand_temp_1 (
        mandant_id,
        kunde_id,
        wup_id,
        nb_id_kunde,
        nb_id_lieferant,
        art_id,
        dat,
        ret_bestand,
        egalisierungsfaktor,
        menge_einh_id,
        nullbestand_exc_fg
)
SELECT  mandant_id,
        kunde_id,
        wup_id,
        nb_id_kunde,
        nb_id_lieferant,
        art_id,
        dat,
        ret_bestand,
        egalisierungsfaktor,
        menge_einh_id,
        nullbestand_exc_fg
FROM    DBP_DATA.art_wup_autodispo_flw_tag_1
WHERE   dat between ${DAT_VON} and ${DAT_BIS}
  --AND tag.dat between '2020-05-05' and '2020-06-07'
;


/*
#------------------------------------------------------------------------------
# 3) UPDATE: ret_bestand aus marktbestand_erp_delta_1 in temp tabelle
#------------------------------------------------------------------------------
*/

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_ret_bestand_temp_1 FROM
(
  SELECT  DISTINCT 
          temp.mandant_id, 
          temp.kunde_id,
          temp.wup_id, 
          temp.art_id, 
          temp.dat,
          mard_delta.menge_lgbest_erp_frei_bme as ret_bestand
  FROM    DBP_ETL.art_wup_autodispo_flw_tag_ret_bestand_temp_1 temp
    JOIN  DBP_DATA.marktbestand_erp_delta_1 mard_delta --vortag
          on temp.mandant_id=mard_delta.mandant_id 
            and temp.art_id=mard_delta.art_id 
            and temp.kunde_id=mard_delta.wup_id
            and temp.dat = mard_delta.dat + 1 
)  AS tbl
SET    ret_bestand = tbl.ret_bestand * egalisierungsfaktor
WHERE  art_wup_autodispo_flw_tag_ret_bestand_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_ret_bestand_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_ret_bestand_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_ret_bestand_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_ret_bestand_temp.dat = tbl.dat
;  


/*
#------------------------------------------------------------------------------
# 4) UPDATE auf art_wup_autodispo_flw_tag_temp_1
#     nullbestand_exc_fg (SPEC0092934)  <--- aus Vorgänger hierher verschoben (SPEC0112174)
#------------------------------------------------------------------------------
*/

-- nullbestand_exc_fg (SPEC0092934)
--LOCKING TABLE DBP_DATA.ausnahme_1 FOR ACCESS
UPDATE DBP_ETL.art_wup_autodispo_flw_tag_ret_bestand_temp_1
SET    nullbestand_exc_fg = 1 
WHERE  (mandant_id, kunde_id, art_id, dat)
       IN (SELECT mandant_id, wup_id, art_id, dat_plan -1 as dat FROM DBP_DATA.ausnahme_1 WHERE pruef_id = 209)
;


/*
#------------------------------------------------------------------------------
# 5) UPDATE Zieltabelle: ret_bestand -> art_wup_autodispo_flw_tag_1
#------------------------------------------------------------------------------
*/

UPDATE  DBP_DATA.art_wup_autodispo_flw_tag_1 
FROM    DBP_ETL.art_wup_autodispo_flw_tag_ret_bestand_temp_1 temp
SET     ret_bestand = temp.ret_bestand,
        nullbestand_exc_fg = temp.nullbestand_exc_fg
WHERE   art_wup_autodispo_flw_tag.mandant_id = temp.mandant_id
  and   art_wup_autodispo_flw_tag.kunde_id = temp.kunde_id
  and   art_wup_autodispo_flw_tag.wup_id = temp.wup_id
  and   art_wup_autodispo_flw_tag.art_id = temp.art_id
  and   art_wup_autodispo_flw_tag.dat = temp.dat
  and   art_wup_autodispo_flw_tag.menge_einh_id = temp.menge_einh_id
;



