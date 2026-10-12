CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_TECHN_PLATZ_SPR_ZU_BG_2
(
	TECHN_PLATZ_ID,
	TECHN_PLATZ_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 13.06.2013 AL Init
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben
-- 04.12.2014 twie: Korrektur tech_platz_bez -> techn_platz_bez

   SELECT
   v01.techn_platz_id,
   COALESCE(ls.tech_platz_bez, de.tech_platz_bez, '') AS techn_platz_bez

   FROM dbp_view.v_techn_platz_per_2   v01
   LEFT OUTER JOIN dbp_view.v_techn_platz_spr_zu_per_2 de
   ON v01.techn_platz_id = de.techn_platz_id AND
   de.dat_bis='9999-12-31' AND
   de.spr_id=22
   LEFT OUTER JOIN dbp_view.v_techn_platz_spr_zu_per_2 ls
   ON v01.techn_platz_id = ls.techn_platz_id AND
   ls.dat_bis='9999-12-31' AND
   ls.spr_id=18

   WHERE v01.dat_bis='9999-12-31'
;