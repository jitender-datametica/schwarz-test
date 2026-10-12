create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_FLW_BEW_2(
	MANDANT_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	LAGERBEW_BELEG_ID,
	BDE_VORGANG_ID,
	WERK_ID,
	CHARGE_ID,
	LAGERORT_ID,
	DAT_ERFASST,
	MIN_DAT_ERFASST,
	ZEIT_ERFASST,
	ZEIT_ERFASST_TS,
	MIN_ZEIT_ERFASST,
	BELEG_GRUPPE_ID,
	DAT_HALTBARKEIT,
	BETRAG_BEW,
	AUFTRAG_ID,
	KJ,
	LOESCH_FG,
	IN_ART_ID,
	DME_EINH_ID,
	NETTOGEW,
	MENGE_BME,
	MENGE_DME,
	MENGE_REWORK,
	FLW_BELEG_TYP_ID,
	MENGE_EINH_ID,
	STORNO_FG,
	STATUS_MB,
	RETOURENPOS_FG,
	WRG_ID,
	DATZEIT_ERSTELLUNG,
	BESTANDSART,
	TERMINAL_ID,
	DAT_HERSTELLUNG,
	EXT_TIERNUMMER,
	MENGE_ERFASST,
	ERFMENGE_EINH_ID,
	BRUTTOGEW,
	TARAGEW,
	SCHNITT_ID,
	UM_LAGERORT_ID,
	UM_IN_ART_ID,
	UM_CHARGE_ID,
	PRUEFLOS_ID,
	IN_LIEF_ID,
	VERWENDUNG_ZIEL_ID,
	BDE_VORGANG_ID_NACHF,
	BDE_VORGANG_ID_VORG,
	BEHAELTER_ID,
	ERZEUGER_1_ID,
	ERZEUGER_2_ID,
	WECHSEL_ID,
	SCHLACHTBETRIEB_ID,
	TRANSPORT_EINHEIT_ID,
	DAT_SCHLACHTUNG,
	DAT_ZERLEGUNG,
	PRUEFLOS_ID_2,
	TIER_KATEGORIE_ID,
	TIER_GATTUNG_ID,
	VPAP_ID,
	FLW_ARBEITSPLATZ_ID,
	PDAO_JOB_ID,
	LAGER_BELEG_ID,
	LAGER_BELEG_POS_ID,
	LAGERNUMMER_ID,
	TRANSPORT_BELEG_ID,
	TRANSPORT_BELEG_POS_ID,
	MFR_TRANSPORT_EINHEIT_ID,
	PDAO_BEDIENER_ID,
	ANZ_RAUCHSTOECKE,
	ANZ_ROHRE,
	FLW_ARBEITSPLATZ_MISCHER_ID,
	FLW_ARBEITSPLATZ1_ID,
	FLW_BEW_GRUND_ID,
	FLW_ZIEL_ID,
	HERKUNFT_ID,
	KOMM_AUFTRAG_POS_ID,
	LAND_GEBOREN_ID,
	LAND_GEMAESTET_ID,
	LAND_GESCHLACHTET_ID,
	LAND_ZERLEGT_ID,
	LIEF_CHARGE_ID,
	MENGE_DIFF_RAUCHKAMMER,
	MENGE_RAUCHSTOECKE,
	MENGE_RAUCHWAGEN,
	NVE_ID,
	RAUCHSTOCK,
	RAUCHSTOECKEMENGE_EINH_ID,
	RAUCHWAGEN_ID,
	RAUCHWAGENMENGE_EINH_ID,
	RAUCHWAGEN_GEWICHT,
	RAUCHSTOECKE_GEWICHT,
	BASISMENGE_EINH_ID,
	MENGE_BASIS,
	KOMPONENTENMENGE
) as
-- 26.10.2011 system_id entfernt
-- 09.10.2013 twie: 8 weitere Felder hinzugefügt
--                Feld gew_einh_id wurde zu altnv_menge_einh_id
-- 17.10.2013 twie: alle Mengen bei stornierten und retournierten Datensätzen mit -1 multiplizieren
--                            somit heben sich Originaldatensatz und Storno bzw. Retourendatensatz gegenseitig auf
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
--01.02.2019  NAKU: SPEC0026284 --> Neue Felde dazu gekommen
--13.08.2019 TWIE: SPEC0045510 Coalesce bei auftrag_id
--12.06.2020 DSIM: SPEC0077388 menge_rework has been added
--13.07.2020 TWIE: SPEC0054374 Bei Werk HN im Warenausgang beim Rauchvorgang das Material ändern wegen Rauchverlusten
--11.05.2022 TWIE: SPEC0140781 menge_basis und komponentenmenge aus Stückliste ergänzt um Sollmenge zu ermitteln


SELECT
mandant_id,
best_beleg_id,
best_beleg_pos_id,
lagerbew_beleg_id,
bde_vorgang_id,
werk_id,
charge_id,
lagerort_id,
dat_erfasst,
min_dat_erfasst,
zeit_erfasst,
/*CAST(dat_erfasst AS TIMESTAMP(0)) + CAST (zeit_erfasst_sec AS INTERVAL SECOND) + 
CAST (zeit_erfasst_min AS INTERVAL MINUTE) + CAST (zeit_erfasst_std AS INTERVAL HOUR)  AS zeit_erfasst_ts, */

TIMESTAMP_NTZ_FROM_PARTS (dat_erfasst, zeit_erfasst) AS zeit_erfasst_ts ,

min_zeit_erfasst,
beleg_gruppe_id,
dat_haltbarkeit,
betrag_bew,
auftrag_id,
kj,
loesch_fg,
in_art_id,
dme_einh_id,
nettogew,
menge_bme,
menge_dme,
menge_rework,
flw_beleg_typ_id,
menge_einh_id,
storno_fg,
status_mb,
retourenpos_fg,
wrg_id,
datzeit_erstellung,
bestandsart,
terminal_id,
dat_herstellung,
ext_tiernummer,
menge_erfasst,
erfmenge_einh_id,
bruttogew,
taragew,
schnitt_id,
um_lagerort_id,
um_in_art_id,
um_charge_id,
prueflos_id,
in_lief_id,
verwendung_ziel_id,
bde_vorgang_id_nachf,
bde_vorgang_id_vorg,
behaelter_id,
erzeuger_1_id,
erzeuger_2_id,
wechsel_id,
schlachtbetrieb_id,
transport_einheit_id,
dat_schlachtung,
dat_zerlegung,
prueflos_id_2,
tier_kategorie_id,
tier_gattung_id,
vpap_id,
flw_arbeitsplatz_id,
pdao_job_id,
lager_beleg_id,
lager_beleg_pos_id,
lagernummer_id,
transport_beleg_id,
transport_beleg_pos_id,
mfr_transport_einheit_id,
pdao_bediener_id,
anz_rauchstoecke,
anz_rohre,
--, flw_arbeitsplatz_id
flw_arbeitsplatz_mischer_id,
flw_arbeitsplatz1_id,
flw_bew_grund_id,
flw_ziel_id,
herkunft_id,
komm_auftrag_pos_id,
land_geboren_id,
land_gemaestet_id,
land_geschlachtet_id,
land_zerlegt_id,
lief_charge_id,
menge_diff_rauchkammer,
menge_rauchstoecke,
menge_rauchwagen,
nve_id,
rauchstock,
rauchstoeckemenge_einh_id,
rauchwagen_id,
rauchwagenmenge_einh_id,
--, rauchkammer_diffmenge_einh_id
rauchwagen_gewicht,
rauchstoecke_gewicht,
basismenge_einh_id,
--, zu_schwer_durch_zu leicht
menge_basis,
komponentenmenge
FROM
(SELECT
v01.mandant_id,
v01.best_beleg_id,
v01.best_beleg_pos_id,
v01.lagerbew_beleg_id,
v01.bde_vorgang_id,
v01.werk_id,
v01.charge_id,
v01.lagerort_id,
v01.dat_erfasst,
v01.min_dat_erfasst,
v01.zeit_erfasst,
v01.min_zeit_erfasst,
v01.beleg_gruppe_id,
v01.dat_haltbarkeit,

CAST(
-- Landesbeleg in Euro wird in Euro angezeigt
 CASE WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
 THEN COALESCE(v01.betrag_bew,0)
 --Landesbeleg in Euro wird in Landeswährung angezeigt
 WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
 THEN COALESCE(v01.betrag_bew,0) / v500.umrechnungskurs
 --Landesbeleg in Landeswährung wird in Euro angezeigt
 WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
 THEN COALESCE(v01.betrag_bew,0) * v500.umrechnungskurs
 --Landesbeleg in Landeswährung wird in Landeswährung angezeigt
 WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
 THEN COALESCE(v01.betrag_bew,0)
 END
 AS DECIMAL(18,6))
 AS betrag_bew,

v01.auftrag_id,
v01.kj,
v01.loesch_fg,
v01.in_art_id,
v01.nettogew,
v01.menge_bme,
v01.menge_dme,
v01.dme_einh_id,
v01.menge_rework,
v01.flw_beleg_typ_id,
v01.storno_fg,
v01.status_mb,
v01.retourenpos_fg,
v01.wrg_id_org AS wrg_id_org,    -- als Zwischenschritt zur besseren Analyse, wird nicht im FE angezeigt
v400.wrg_id AS wrg_id,
v01.datzeit_erstellung,
v01.menge_einh_id  AS menge_einh_id,
v01.bestandsart,
v01.terminal_id,
v01.dat_herstellung,
v01.ext_tiernummer,
v01.menge_erfasst AS menge_erfasst,
v01.erfmenge_einh_id,
v01.bruttogew AS bruttogew,
v01.taragew AS taragew,
v01.schnitt_id,
v01.um_lagerort_id,
v01.um_in_art_id AS um_in_art_id,
v01.um_charge_id,
v01.prueflos_id,
v01.in_lief_id AS in_lief_id,
v01.verwendung_ziel_id,
v01.bde_vorgang_id_nachf,
v01.bde_vorgang_id_vorg,
v01.behaelter_id,
v01.erzeuger_1_id,
v01.erzeuger_2_id,
v01.wechsel_id,
v01.schlachtbetrieb_id,
v01.transport_einheit_id,
v01.dat_schlachtung,
v01.dat_zerlegung,
v01.prueflos_id_2,
v01.tier_kategorie_id,
v01.tier_gattung_id,
v01.vpap_id,
v01.flw_arbeitsplatz_id,

 /*MOD( v01.zeit_erfasst, 100) AS zeit_erfasst_sec,
MOD((v01.zeit_erfasst - zeit_erfasst_sec) / 100, 100) AS zeit_erfasst_min,
(v01.zeit_erfasst - zeit_erfasst_min *100 -zeit_erfasst_sec) /10000 AS zeit_erfasst_std, */
 
v01.pdao_job_id,
v01.lager_beleg_id,
v01.lager_beleg_pos_id,
v01.lagernummer_id,
v01.transport_beleg_id,
v01.transport_beleg_pos_id,
v01.mfr_transport_einheit_id,
v01.pdao_bediener_id,
v01.anz_rauchstoecke,
v01.anz_rohre,
--, v01.flw_arbeitsplatz_id
v01.flw_arbeitsplatz_mischer_id,
v01.flw_arbeitsplatz1_id,
v01.flw_bew_grund_id,
v01.flw_ziel_id,
v01.herkunft_id,
v01.komm_auftrag_pos_id,
v01.land_geboren_id,
v01.land_gemaestet_id,
v01.land_geschlachtet_id,
v01.land_zerlegt_id,
v01.lief_charge_id,
v01.menge_diff_rauchkammer,
v01.menge_rauchstoecke,
v01.menge_rauchwagen,
v01.nve_id,
v01.rauchstock,
v01.rauchstoeckemenge_einh_id,
v01.rauchwagen_id,
v01.rauchwagenmenge_einh_id,
--, v01.rauchkammer_diffmenge_einh_id
v01.menge_rauchwagen || '  ' || v01.rauchwagenmenge_einh_id                     AS  rauchwagen_gewicht,
v01.menge_rauchstoecke || '  ' || v01.rauchstoeckemenge_einh_id                 AS   rauchstoecke_gewicht,
v01.basismenge_einh_id,
--,(v01.menge_diff_rauchkammer / v01.rauchkammer_diffmenge_einh_id )   AS  zu_schwer_durch_zu leicht
v01.menge_basis,
v01.komponentenmenge

FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_FLW_BEW_2 v01


-- Ermittlung der eingestellter Währung
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200

-- Ermittlung ob Tageskurs / Kaufland Kurs_2
CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300

JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400
ON v01.mandant_id = v400.mandant_id
AND v200.wrg_typ_id = v400.wrg_typ_id

--Umrechnung Standardkurs, Tageskurs
LEFT OUTER JOIN dbp_view.v_kurs_2 v500
ON v300.kurstyp_id = v500.kurstyp_id
AND v01.wrg_id = v500.von_wrg_id
AND v500.nach_wrg_id ='EUR'
AND v01.dat_erfasst BETWEEN v500.dat_von AND v500.dat_bis
) dt1;