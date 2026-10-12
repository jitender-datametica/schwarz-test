CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_MO_TYP_1(
	MO_TYP_ID,
	MO_TYP_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
-- 2016-10-25 ttez1905; Lookup View fur Mietobjekt Typ; Status_1:Initial/nicht fertig
-- 2017-03-20 ttez1905; Mandant_1 rausgenommen
-- 2022-11-21 richternic: Nur ID und BEZ -> sonst kommt es zur Vervielfachung in den Prompts
SELECT
   DISTINCT v0.mo_typ_id,
   v0.mo_typ_bez
FROM
   dbp_view.v_immo_l_mo_typ_1 v0 
--WHERE mandant_id = 1
;