CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_VORSTAND_1(
	MANDANT_ID,
	MITARBEITER_ID,
	VORNAME,
	NACHNAME,
	ANREDE
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
 -- 20121030 Anpassung  Join (mandant_id)
 -- 20200721 SPEC0081244 sanadze: Initialisierung

SELECT
o.mandant_id
, o.zustaendig_id                               Mitarbeiter_ID
, MAX(z.vorname)                                vorname
, MAX(z.nachname)                               nachname
, MAX(z.anrede)                                 anrede

FROM  dbp_view.v_ivs_objekt_zustaendig_zu_per_1  o

JOIN  dbp_view.v_ivs_immo_zustaendig_1  z
ON    o.zustaendig_id = z.zustaendig_id
AND o.mandant_id = z.mandant_id

WHERE o.zustaendig_typ_id = 1
AND   dat_bis = '9999-12-31'

GROUP BY
o.mandant_id
, o.zustaendig_id;