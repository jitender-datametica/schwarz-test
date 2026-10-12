create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_IOS.MV_CPR_PHASE_2(
	PROJEKT_PHASE_ID,
	PROJEKT_ID,
	PROJEKT_NR,
	PHASE_NR,
	PHASENART_ID,
	CPR_PHASE_GRUPPE_ID,
	DAT_FREIGABE,
	CPR_SUCHFELD,
	TEIL_MASSN_FG,
	BAUABSCHNITT_ID,
	BAUABSCHNITT_BEZ,
	BAUABSCHNITT_LANGTEXT,
	BAUABSCHNITT_ABGELAUFEN_FG,
	BAUABSCHNITT_NR,
	EINZEL_MASSNAHME,
	TEIL_MASSNAHME_ID,
	CPR_SYSTEMSTATUS1_ID,
	CPR_SYSTEMSTATUS2_ID,
	CPR_SYSTEMSTATUS3_ID,
	MANDANT_ID,
	CPR_PHASE_VERSION_ID,
	CPR_PHASE_VERSION_DAT,
	AUFGABENART_ID
) as
--MCan1401: Redesign und Optimierung der View inkl .Einbau Bauabschnittslogik!
SELECT
ph.projekt_phase_id
, ph.projekt_id
, pr.cpr_ext_id AS projekt_nr
, ph.cpr_ext_id AS phase_nr
, ph.phasenart_id
, CAST(NULL AS VARCHAR(40)) AS cpr_phase_gruppe_id
, ph.dat_freigabe
, c.cpr_suchfeld AS cpr_suchfeld
, ph.teil_massn_kz AS teil_massn_fg

, bas.bauabschnitt_id
, bas.bauabschnitt_bez
, bas.bauabschnitt_langtext
, bas.bauabschnitt_abgelaufen_fg
-- ALIAS für lfd_nr
, SUBSTRING(bas.bauabschnitt_id,33, 4)  AS bauabschnitt_nr

, COALESCE (ph.einzel_massnahme, ' ') AS einzel_massnahme
, ph.teil_massnahme_id
, ph.cpr_systemstatus1_id
, ph.cpr_systemstatus2_id
, ph.cpr_systemstatus3_id
, pr.mandant_id

-- 20120215: k.kaiser 2 Felder version_phase,  dat_von_phase
, ph.cpr_phase_version_id AS cpr_phase_version_id
, ph.cpr_phase_version_dat AS cpr_phase_version_dat
, '  ' AS aufgabenart_id

FROM dbp_view.v_cpr_phase_per_2    ph

JOIN dbp_view.v_cpr_projekt_per_2   pr
ON   ph.projekt_id = pr.projekt_id
AND  pr.dat_bis = '9999-12-31'
AND  ph.dat_bis = '9999-12-31'

/*LEFT*/
JOIN dbp_view.v_l_cpr_suchfeld_2 c
ON ph.cpr_suchfeld_id = c.cpr_suchfeld_id

LEFT JOIN (Select
projekt_nr
,projekt_phase_id
,bauabschnitt_id
,bauabschnitt_nr
,bauabschnitt_bez
,bauabschnitt_langtext
,bauabschnitt_abgelaufen_fg
from
dbp_msi_view_ios.mv_projekt_bauabschnitt_2 bas

group by 1,2,3,4,5,6,7) bas
ON  pr.cpr_ext_id = bas.projekt_nr
AND ph.projekt_phase_id = bas.projekt_phase_id

LEFT JOIN dbp_view.v_cpr_aufgabe_per_2   au
ON   au.projekt_phase_id = ph.projekt_phase_id
AND  au.dat_bis = '9999-12-31';