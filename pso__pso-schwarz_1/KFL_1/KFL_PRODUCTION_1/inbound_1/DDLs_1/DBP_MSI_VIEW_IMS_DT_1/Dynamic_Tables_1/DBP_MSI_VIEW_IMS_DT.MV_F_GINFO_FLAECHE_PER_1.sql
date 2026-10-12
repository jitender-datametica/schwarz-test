CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_F_GINFO_FLAECHE_PER_1
(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	TECHN_PLATZ_ID,
	GINFO_FLAECHE_ID,
	GINFO_FLAECHE_TYP_ID,
	GINFO_FLAECHE_NETTO,
	GINFO_FLAECHE_BRUTTO,
	GINFO_ACHSE_WERT,
	GINFO_ACHSE_TYP_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 11.04.2013 twie: Fakttabelle mit Flaechenkennzahlen

   SELECT

   wp.mandant_id,
   wp.nb_id,
   wp.wup_id,
   tpl.techn_platz_id,
   flp.ginfo_flaeche_id,
   flp.ginfo_flaeche_typ_id,
   flp.ginfo_flaeche_netto,
   flp.ginfo_flaeche_brutto,
   flp.ginfo_achse_wert,
   flp.ginfo_achse_typ_id

   FROM
   ( -- Marktstamm
   SELECT mandant_id,
   nb_id,
   wup_id
  FROM dbp_view.v_wup_1
  ) wp
   LEFT JOIN
   ( -- Techn. Platz
   SELECT mandant_id,
   techn_platz_id,
   wup_id
  FROM dbp_view.v_techn_platz_per_1
  WHERE techn_platz_ebene_id = 2 AND dat_bis = '9999-12-31'
  ) tpl
   ON wp.mandant_id = tpl.mandant_id
   AND wp.wup_id = tpl.wup_id
   LEFT OUTER JOIN dbp_view.v_ginfo_flaeche_per_1 flp
   ON   tpl.techn_platz_id = flp.techn_platz_id
   AND CURRENT_DATE BETWEEN dat_von AND dat_bis
   ;