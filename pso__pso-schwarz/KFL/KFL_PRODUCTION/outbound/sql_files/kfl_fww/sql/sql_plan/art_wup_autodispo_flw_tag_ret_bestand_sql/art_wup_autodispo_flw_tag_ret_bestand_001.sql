DROP TABLE IF EXISTS dbp_etl.art_wup_autodispo_flw_tag_ret_bestand_temp;


CREATE TABLE IF NOT EXISTS dbp_etl.art_wup_autodispo_flw_tag_ret_bestand_temp (
mandant_id INTEGER NOT NULL,
kunde_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id_kunde INTEGER NOT NULL,
nb_id_lieferant INTEGER NOT NULL,
art_id INTEGER NOT NULL,
dat DATE NOT NULL,
ret_bestand NUMERIC(29,3),
egalisierungsfaktor NUMERIC(29,7),
menge_einh_id STRING(10),
nullbestand_exc_fg INTEGER DEFAULT 0
);

/*
#------------------------------------------------------------------------------
# 2) Daten aus dbp_data.art_wup_autodispo_flw_tag holen
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_etl.art_wup_autodispo_flw_tag_ret_bestand_temp (mandant_id, kunde_id, wup_id, nb_id_kunde
 , nb_id_lieferant, art_id, dat, ret_bestand, egalisierungsfaktor, menge_einh_id, nullbestand_exc_fg)
(SELECT mandant_id,
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
 FROM dbp_data.art_wup_autodispo_flw_tag
 WHERE dat BETWEEN ${DAT_VON} AND ${DAT_BIS})
  --AND tag.dat between '2020-05-05' and '2020-06-07'
;


/*
#------------------------------------------------------------------------------
# 3) UPDATE: ret_bestand aus marktbestand_erp_delta in temp tabelle
#------------------------------------------------------------------------------
*/

UPDATE dbp_etl.art_wup_autodispo_flw_tag_ret_bestand_temp SET
 ret_bestand = CAST(tbl.ret_bestand * art_wup_autodispo_flw_tag_ret_bestand_temp.egalisierungsfaktor AS NUMERIC) FROM (SELECT
  DISTINCT TEMP.mandant_id,
   TEMP.kunde_id,
   TEMP.wup_id,
   TEMP.art_id,
   TEMP.dat,
   MARD_DELTA.menge_lgbest_erp_frei_bme AS ret_bestand
  FROM dbp_etl.art_wup_autodispo_flw_tag_ret_bestand_temp AS TEMP
   INNER JOIN dbp_data.marktbestand_erp_delta AS MARD_DELTA ON TEMP.mandant_id = MARD_DELTA.mandant_id
      AND TEMP.art_id = MARD_DELTA.art_id AND TEMP.kunde_id = MARD_DELTA.wup_id AND TEMP.dat = DATE_ADD(MARD_DELTA.dat,
      INTERVAL 1 DAY)) AS tbl
WHERE art_wup_autodispo_flw_tag_ret_bestand_temp.mandant_id = tbl.mandant_id AND
     art_wup_autodispo_flw_tag_ret_bestand_temp.art_id = tbl.art_id AND art_wup_autodispo_flw_tag_ret_bestand_temp.kunde_id
     = tbl.kunde_id AND art_wup_autodispo_flw_tag_ret_bestand_temp.wup_id = tbl.wup_id AND
  art_wup_autodispo_flw_tag_ret_bestand_temp.dat = tbl.dat;

/*
#------------------------------------------------------------------------------
# 4) UPDATE auf art_wup_autodispo_flw_tag_temp
#     nullbestand_exc_fg (SPEC0092934)  <--- aus Vorgänger hierher verschoben (SPEC0112174)
#------------------------------------------------------------------------------
*/

-- nullbestand_exc_fg (SPEC0092934)
--LOCKING TABLE DBP_DATA.ausnahme FOR ACCESS
UPDATE dbp_etl.art_wup_autodispo_flw_tag_ret_bestand_temp SET
 nullbestand_exc_fg = 1
WHERE (mandant_id, kunde_id, art_id, dat) IN (SELECT (mandant_id, wup_id, art_id, DATE_SUB(dat_plan, INTERVAL 1 DAY))
  FROM dbp_data.ausnahme
  WHERE pruef_id = 209);


/*
#------------------------------------------------------------------------------
# 5) UPDATE Zieltabelle: ret_bestand -> art_wup_autodispo_flw_tag
#------------------------------------------------------------------------------
*/


UPDATE dbp_data.art_wup_autodispo_flw_tag SET
 ret_bestand = TEMP.ret_bestand,
 nullbestand_exc_fg = TEMP.nullbestand_exc_fg FROM dbp_etl.art_wup_autodispo_flw_tag_ret_bestand_temp AS
 TEMP
WHERE art_wup_autodispo_flw_tag.mandant_id = TEMP.mandant_id AND art_wup_autodispo_flw_tag.kunde_id = TEMP.kunde_id AND
     art_wup_autodispo_flw_tag.wup_id = TEMP.wup_id AND art_wup_autodispo_flw_tag.art_id = TEMP.art_id AND
   art_wup_autodispo_flw_tag.dat = TEMP.dat AND art_wup_autodispo_flw_tag.menge_einh_id = TEMP.menge_einh_id;