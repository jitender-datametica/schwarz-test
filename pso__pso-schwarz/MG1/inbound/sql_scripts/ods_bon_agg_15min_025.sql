--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS dbp_etl.vis_tag_kasse;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE TABLE dbp_etl.vis_tag_kasse  (
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      mandant_id BYTEINT NOT NULL,
      dat DATE NOT NULL,
      kasse_nr SMALLINT NOT NULL,
      kasse_typ_id BYTEINT NOT NULL DEFAULT -1  ,
      kassierzeit DECIMAL(9,2) NOT NULL DEFAULT 0.00 ,
      anz_artikel INTEGER NOT NULL DEFAULT 0 ,
      registrierzeit DECIMAL(9,2),
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000  ,
      anz_kunden INTEGER NOT NULL DEFAULT 0  ,
      kassiervorgangszeit INTEGER NOT NULL DEFAULT 0 )
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO dbp_etl.vis_tag_kasse
(
wup_id, 
nb_id, 
mandant_id, 
dat, 
kasse_nr, 
kasse_typ_id,
kassierzeit, 
anz_artikel, 
registrierzeit, 
umsatz_netto, 
anz_kunden,
kassiervorgangszeit
)
SELECT 
   agg.wup_id,
   0 as nb_id,
   agg.mandant_id,
   agg.dat,
   agg.kasse_nr,
   agg.kasse_typ_id,
   SUM(kassierzeit    ) AS kassierzeit,
   SUM(anz_artikel    ) AS anz_artikel,
   SUM(registrierzeit ) AS registrierzeit,
   SUM(umsatz_netto   ) AS umsatz_netto,
   SUM(anz_kunden     ) AS anz_kunden,
   SUM(registrierzeit + zahlzeit) AS kassiervorgangszeit
   
FROM dbp_ods.ods_bon_agg_15min agg
INNER JOIN dbp_etl.bon_agg_kassenberichte k

ON k.mandant_id = agg.mandant_id
AND k.wup_id = agg.wup_id
and k.bon_dat = agg.dat
and k.kasse_nr = agg.kasse_nr

WHERE k.bon_dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE-1

GROUP BY 1,2,3,4,5,6;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM dbp_data.vis_tag_kasse
WHERE dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE-1
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO dbp_data.vis_tag_kasse
(
wup_id, 
nb_id, 
mandant_id, 
dat, 
kasse_nr, 
kasse_typ_id,
kassierzeit, 
anz_artikel, 
registrierzeit, 
umsatz_netto, 
anz_kunden,
kassiervorgangszeit
)
SELECT
wup_id, 
nb_id, 
mandant_id, 
dat, 
kasse_nr, 
kasse_typ_id,
kassierzeit, 
anz_artikel, 
registrierzeit, 
umsatz_netto, 
anz_kunden,
kassiervorgangszeit
   
FROM dbp_etl.vis_tag_kasse
WHERE dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE-1
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE dbp_ods.bon_load_status
SET ods_bon_agg_fg=1
WHERE (xml_name) IN
(SELECT xml_name FROM dbp_etl.bon_agg_kassenberichte_tmp)
;

