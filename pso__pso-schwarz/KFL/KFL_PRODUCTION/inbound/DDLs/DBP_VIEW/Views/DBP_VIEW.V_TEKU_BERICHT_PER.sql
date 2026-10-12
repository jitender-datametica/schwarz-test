CREATE OR REPLACE VIEW DBP_VIEW.V_TEKU_BERICHT_PER
AS SELECT
teku_bericht_id,
dat_von,
dat_bis,
dat_besuchs_beginn,
try_to_time(to_char(MOD(zeit_besuchs_beginn,'240000'),'000000'),'HH24MISS') as zeit_besuchs_beginn,
dat_besuchs_ende,
try_to_time(to_char(MOD(zeit_besuchs_ende,'240000'),'000000'),'HH24MISS') as zeit_besuchs_ende,
mandant_id,
wup_id,
teku_checkliste_id,
testkunde_id,
loeschung_fg,
nicht_auswerten_fg,
dat_erfasst
FROM dbp_data.teku_bericht_per

;