CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_F_MARKT_VERBRAUCH
(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	DAT,
	GP_ID,
	MARKT_VERBRAUCH_MENGE,
	MARKT_VERBRAUCH_EKN,
	MARKT_VERBRAUCH_EKN_BNK
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
mandant_id, 
wup_id, 
nb_id, 
art_id, 
dat, 
gp_id, 
menge AS markt_verbrauch_menge, 
ek_netto AS markt_verbrauch_ekn, 
ek_netto_bnk AS markt_verbrauch_ekn_bnk

FROM dbp_view.v_artbew
WHERE mandant_id = 1;
