CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ARTBEW_MO_EK_CP_SUM
(
MANDANT_ID,
ART_ID,
GP_ID,
BEWART_ID,
WUP_ID,
NB_ID,
KJMO,
WRG_ID,
WUP_BEREINIGT_FG,
ZEK_ID,
EIGENMARKE_FG,
UMSATZ_NETTO,
UMSATZ_NETTO_VJ,
BETRAG_KMEP,
BETRAG_KMEP_VJ,
LOGKOSTENZUSCHLAG,
LOGKOSTENZUSCHLAG_VJ,
WERBE_ABSCHRIFT_NETTO,
WERBE_ABSCHRIFT_NETTO_VJ,
PREIS_ABSCHRIFT_NETTO,
PREIS_ABSCHRIFT_NETTO_VJ
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
mandant_id,
art_id,
-- AP0281473/SPEC0323868 Erweiterung um Lieferant / prescherad 14.08.2025
gp_id, 
bewart_id,
wup_id,
nb_id,
kjmo,
wrg_id,
wup_bereinigt_fg,
zek_id,
eigenmarke_fg,
umsatz_netto,
umsatz_netto_vj,
betrag_kmep,
betrag_kmep_vj,
logkostenzuschlag,
logkostenzuschlag_vj,
werbe_abschrift_netto,
werbe_abschrift_netto_vj,
preis_abschrift_netto,
preis_abschrift_netto_vj

FROM dbp_data.artbew_mo_ek_cp_sum
WHERE mandant_id = 1
AND wup_bereinigt_fg =0;