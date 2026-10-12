CREATE OR REPLACE VIEW dbp_msi_view_flw.mv_l_objekt_1
-- 29.05.2019, pjan1603. SPEC0045510 new lookup table created for "Objektnummer", "Produktionsdatum1", and "Verpackungsdatum" attributes
-- 01.10.2019 twie: SPEC0045510 Überarbeitung View, Objektschlüssel nicht relevant für Frontend, Join zu mv_l_in_charge_art_zu_1 über objekt_nummer_id
--                            Außerdem keine echten Lookuptabelle, insbesondere für dat_produktion1 und dat_verpackung, aber Attribute nur zur Anzeige auf Schablone benötigt
-- 21.11.2019 twie: SPEC0054374 dat_fuell ergänzt

(
 mandant_id
,objekt_nummer_id
,dat_produktion1 --[sic]
,dat_verpackung
,dat_fuell
)
AS
SELECT

mandant_id,
objekt_nummer_id,
MAX(CASE WHEN int_merkmal_id = 1621 THEN dat_wert ELSE NULL END) AS dat_produktion1,
MAX(CASE WHEN int_merkmal_id = 1624 THEN dat_wert ELSE NULL END) AS dat_verpackung,
MAX(CASE WHEN int_merkmal_id = 1625 THEN dat_wert ELSE NULL END) AS dat_fuell
FROM dbp_view.v_flw_charge_objekt_merkmal_zu_1

GROUP BY
 mandant_id
,objekt_nummer_id;