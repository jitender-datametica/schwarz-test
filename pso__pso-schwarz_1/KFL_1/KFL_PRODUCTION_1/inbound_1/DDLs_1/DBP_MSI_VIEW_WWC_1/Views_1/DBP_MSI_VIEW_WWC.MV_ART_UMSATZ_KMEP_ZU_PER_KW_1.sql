CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_UMSATZ_KMEP_ZU_PER_KW_1
(
mandant_id
,nb_id
,art_id
,zeitraum_kz
,dat_von
,dat_bis
,betrag_kmep
,betrag_kmep_einh
,betrag_kmep_einh_o_fwu
,kjwo
)
AS
-- 04.05.2017, AP0011863, srom, initial, Es gibt eine_1 parallele View auf Monatsbasis bzw. Werbewochenbasis
-- nb_id wird als 0 aufgenommen, damit Metrik in Bericht nicht Dimensioniert werden muss (Securityfilter)
-- Im bestehenden Bericht wird schon vor KMEP auf nb_id = 0 gefiltert
-- 03.09.2018, AP0022217, SPEC0041095, srom - Neue Metrik WA-Kalk SA
-- 08.12.2022, SPEC0174299. prescherad: Neue Metrik BETRAG_KMEP_EINH_O_FWU
   SELECT
   v01.mandant_id, 0 AS nb_id, v01.art_id, v01.zeitraum_kz, v01.dat_von, v01.dat_bis, v01.betrag_kmep, v01.betrag_kmep_einh, v01.betrag_kmep_einh_o_fwu, v02.kjwo AS kjwo
   FROM dbp_view.v_art_umsatz_kmep_zu_per_1 v01
   INNER JOIN dbp_view.v_tag_1 v02
   ON v01.dat_von = v02.dat
   WHERE zeitraum_kz = 'KW';