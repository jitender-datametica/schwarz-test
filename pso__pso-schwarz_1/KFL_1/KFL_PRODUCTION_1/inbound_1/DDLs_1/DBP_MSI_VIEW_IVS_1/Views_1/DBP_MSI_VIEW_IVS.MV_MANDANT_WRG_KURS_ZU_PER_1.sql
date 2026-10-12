CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MANDANT_WRG_KURS_ZU_PER_1
AS
-- 2009-06-15
-- ZUORDNUNG Mandant_1-Währungstyp-Währung-Kurs_1 (zeitabhängig)
-- 2009KW27 initial, historisierte Abbildung von Kursen
-- 2012/KW38 Neuerstllung: Betraege von Landeswaehrung nach Euro umrechnen, nur Beritskurs 809912311

SELECT
mwt.mandant_id
,mwt.wrg_id
,mwt.wrg_typ_id
,CASE WHEN wrg_typ_id = 0 THEN lw.umrechnungskurs ELSE 1.0000000 END AS kurs_1
,1/ kurs_1 AS umrechnungskurs
,CAST('1900-01-01' AS DATE)   kurs_dat_von
,CAST('9999-12-31' AS DATE)  kurs_dat_bis
FROM dbp_view.v_mandant_wrg_typ_zu_1  mwt

INNER JOIN dbp_view.v_mandant_1 m
ON mwt.mandant_id = m.mandant_id

INNER JOIN dbp_view.v_kurs_1 lw
ON lw.von_wrg_id = m.default_wrg
AND lw.nach_wrg_id = 'EUR'
AND  lw.kurstyp_id = 3
AND lw.dat_bis = CAST('9999-12-31' AS DATE);