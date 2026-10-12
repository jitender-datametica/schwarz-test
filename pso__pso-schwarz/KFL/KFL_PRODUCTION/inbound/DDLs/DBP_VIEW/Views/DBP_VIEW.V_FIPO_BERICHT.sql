CREATE OR REPLACE VIEW DBP_VIEW.V_FIPO_BERICHT
AS SELECT
fipo_bericht_id,
fipo_pruef_objekt_id,
fipo_pruef_modul_id,
dat_fipo_bericht,
mobil_erfasst_fg,
nicht_auswerten_fg,
fipo_person_id,
dat_bis,
try_to_time(to_char(MOD(zeit_fipo_bericht,'240000'),'000000'),'HH24MISS') as zeit_fipo_bericht,
fipo_bericht_text,
dat_versorgung
FROM dbp_data.fipo_bericht

;