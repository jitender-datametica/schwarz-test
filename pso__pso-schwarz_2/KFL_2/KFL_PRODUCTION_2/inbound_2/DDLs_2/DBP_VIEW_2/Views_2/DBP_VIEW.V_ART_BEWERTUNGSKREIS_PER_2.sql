CREATE OR REPLACE VIEW DBP_VIEW.V_ART_BEWERTUNGSKREIS_PER_2
AS SELECT
mandant_id,
bewertungskreis_id,
art_id,
dat_von,
preis_steuer_kz,
wrg_id,
dat_bis,
dat_aenderung,
try_to_time(to_char(MOD(zeit_aenderung,'240000'),'000000'),'HH24MISS') as zeit_aenderung,
gld,
standard_preis,
menge_bestand_bme,
wert_bestand,
vk_wert
FROM dbp_data.art_bewertungskreis_per_2
;