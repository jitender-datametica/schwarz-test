CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_LAGERBEW_DET_DISPLAY_1
AS
SELECT
mandant_id,
lagerbew_beleg_id,
lagerbew_beleg_pos_id,
kj,
lager_bewart_id,
art_id,
wup_id,
nb_id,
gp_id,
soll_haben_kz,
best_beleg_id,
menge_lagerbew_kolli,
menge_lagerbew_bme,
betrag_lagerbew,
dat_buch,
display_art_id,
line_id,
lagerbew_beleg_pos_mutter_id
FROM dbp_data.lagerbew_det_1
WHERE (lager_bewart_id IN ('319','317',  '101', '102', '901','902') AND mandant_id <> 1) OR
      (lager_bewart_id IN ('319','317',  '101', '102', '901','902', '905', '906', '913', '915' ) AND mandant_id = 1);