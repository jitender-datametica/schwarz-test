CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_ART_MUTTER_2
-- 17.03.2017 lwei QUEST0070862:Anpassung Feld PMATA_SAP in ANRMU_SAP umbenannt
-- art_id_mutter neu, damit korrekt zu der Sprachview ge-joined wird
(
art_id,
mandant_id,
art_id_mutter,
ANRMU_SAP,
dat_von,
dat_bis
)
AS
   SELECT
   v01.art_id,
   v01.mandant_id,
   v02.art_id AS art_id_mutter,
   CASE WHEN v02.artikelart_id = 'MWST' THEN TO_VARCHAR(v02.kl_art_id, 'FM0000')
   ELSE TO_VARCHAR(v02.kl_art_id, 'FM00000000')
   END AS ANRMU_SAP,
   v01.dat_von,
   v01.dat_bis
   FROM dbp_view.v_art_2 v01
   INNER JOIN dbp_view.v_art_2 v02
   ON V01.mandant_id = v02.mandant_id
   AND V01.mutter_vk_id = v02.art_id
   WHERE v01.dat_bis='9999-12-31'
   AND v02.dat_bis='9999-12-31';