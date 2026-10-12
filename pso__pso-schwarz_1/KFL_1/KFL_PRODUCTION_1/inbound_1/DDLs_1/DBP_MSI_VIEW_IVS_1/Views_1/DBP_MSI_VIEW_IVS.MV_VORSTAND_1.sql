CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_VORSTAND_1
AS
-- 20121030 Anpassung  Join (mandant_id)


SELECT
o.mandant_id
, o.zustaendig_id                               Mitarbeiter_ID
, MAX(z.vorname)                                vorname
, MAX(z.nachname)                               nachname
, MAX(z.anrede)                                 anrede

FROM  dbp_view.v_ivs_objekt_zustaendig_zu_per_1  o

JOIN  dbp_view.v_ivs_immo_zustaendig_1  z
ON    o.zustaendig_id = z.zustaendig_id
and o.mandant_id = z.mandant_id

WHERE o.zustaendig_typ_id = 1
AND   dat_bis = CAST('9999-12-31' AS DATE)

GROUP BY
o.mandant_id
, o.zustaendig_id;