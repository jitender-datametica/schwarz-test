CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_BEW_2

(
  mandant_id
, best_beleg_id
, best_beleg_pos_id
, lagerbew_beleg_id
, bde_vorgang_id
, werk_id
, charge_id
, lagerort_id
, dat_erfasst
, min_dat_erfasst
, zeit_erfasst
, zeit_erfasst_ts
, min_zeit_erfasst
, beleg_gruppe_id
, dat_haltbarkeit
, betrag_bew
, auftrag_id
, kj
, loesch_fg
, in_art_id
, dme_einh_id
, nettogew
, menge_bme
, menge_dme
, menge_rework
, flw_beleg_typ_id
, menge_einh_id  -- GEWEI
, storno_fg
, status_mb
, retourenpos_fg
, datzeit_erstellung
-- neue 30 Spalten
, bestandsart  -- INSMK
, terminal_id  -- TERMI
, dat_herstellung  --HSDAT herstellum
, ext_tiernummer -- EXTNR ident
, menge_erfasst  --ERFMG
, erfmenge_einh_id  -- ERFME
, bruttogew   --BRGEW
, taragew     -- TAGEW
, schnitt_id -- CUTNR
, um_lagerort_id --  UMLGO
, um_in_art_id   --  UMMAT
, um_charge_id   --  UMCHA
, prueflos_id    --  QPLOS
, in_lief_id     -- LIFNR
, verwendung_ziel_id
, bde_vorgang_id_nachf --  OPRNR_SU
, bde_vorgang_id_vorg  --  OPRNR_PD
, behaelter_id        --   CONID
, erzeuger_1_id      --    ZZEZ1NR
, erzeuger_2_id   --    ZZEZ2NR
, wechsel_id       --      ZZCHGID
, schlachtbetrieb_id  --   ZZESNUM
, transport_einheit_id  -- TENUM
, dat_schlachtung      --  ZZSLDAT
, dat_zerlegung      --  ZZZLDAT
, prueflos_id_2    --  ZZQPLOS
, tier_kategorie_id    --  ZZFLKAT
, tier_gattung_id   --  ZZTGTKY
, vpap_id  --  ZZVPAPNR 
, flw_arbeitsplatz_id  -- ZZARBPL
, pdao_job_id --JOBNR
, lager_beleg_id --LBELN
, lager_beleg_pos_id  --LPOSN
, lagernummer_id --LGNUM
, transport_beleg_id --TANUM
, transport_beleg_pos_id --TAPOS
, mfr_transport_einheit_id --ZZTENUM
, pdao_bediener_id --ZZBEDNR

, anz_rauchstoecke
, anz_rohre
--, flw_arbeitsplatz_id
, flw_arbeitsplatz_mischer_id
, flw_arbeitsplatz1_id
, flw_bew_grund_id
, flw_ziel_id
, herkunft_id
, komm_auftrag_pos_id
, land_geboren_id
, land_gemaestet_id
, land_geschlachtet_id
, land_zerlegt_id
, lief_charge_id
, menge_diff_rauchkammer
, menge_rauchstoecke
, menge_rauchwagen
, nve_id
, rauchstock
, rauchstoeckemenge_einh_id
, rauchwagen_id
, rauchwagenmenge_einh_id
--, rauchkammer_diffmenge_einh_id
, rauchwagen_gewicht
, rauchstoecke_gewicht
, basismenge_einh_id
--, zu_schwer_durch_zu leicht

  , wrg_id
  , default_wrg
  ,wrg_id_org
  ,menge_basis
  ,komponentenmenge
)

AS

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
--03.06.2022 RICHTERNIC: INC4801370 Anpassung menge_basis und komponentenmenge -> Summiert sonst werden dupplikate erzeugt 
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
basismenge_einh_id
--, zu_schwer_durch_zu leicht

,wrg_id
,default_wrg
,wrg_id_org
,menge_basis
,komponentenmenge
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
v01.betrag_bew AS betrag_bew,

CASE WHEN v01.auftrag_id <> '' THEN v01.auftrag_id ELSE '-1' END AS auftrag_id,
v01.kj,
v01.loesch_fg,
--Für den Rauchprozess in Werk Heilbronn wird im Warenausgang die um_flw_art_id benötigt, da Eingangs- ungleich Ausgangsmaterial ist
CASE WHEN v01.werk_id = 5 AND v01.mandant_id = 1 AND v01.flw_beleg_typ_id = 'WA'
    AND v02.transport_einheit_id IS NOT NULL THEN v01.um_flw_art_id ELSE v01.flw_art_id END AS in_art_id,
v01.dme_einh_id,
CASE
WHEN v01.storno_fg = 1 OR v01.retourenpos_fg = 1 THEN -1
 ELSE 1
 END
 AS vorzeichen,
v01.nettogew * vorzeichen AS nettogew,
v01.menge_bme * vorzeichen AS menge_bme,
v01.menge_dme * vorzeichen AS menge_dme,
CASE
WHEN v01.flw_beleg_typ_id = 'WA' OR v01.flw_beleg_typ_id = 'V1' THEN v01.menge_bme * vorzeichen *(-1 )
 ELSE v01.menge_bme * vorzeichen
 END
 AS menge_rework,
v01.flw_beleg_typ_id,
v01.storno_fg,
v01.status_mb,
v01.retourenpos_fg,
v01.wrg_id AS wrg_id_org,    -- als Zwischenschritt zur besseren Analyse, wird nicht im FE angezeigt
v01.datzeit_erstellung,
v01.altnv_menge_einh_id  AS menge_einh_id,
v01.bestandsart,
v01.terminal_id,
v01.dat_herstellung,
v01.ext_tiernummer,
v01.menge_erfasst * vorzeichen AS menge_erfasst,
v01.erfmenge_einh_id,
v01.bruttogew * vorzeichen AS bruttogew,
v01.taragew * vorzeichen AS taragew,
v01.schnitt_id,
v01.um_lagerort_id,
v01.um_flw_art_id AS um_in_art_id,
v01.um_charge_id,
v01.prueflos_id,
v01.flw_lief_id AS in_lief_id,
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
v01.basismenge_einh_id
--,(v01.menge_diff_rauchkammer / v01.rauchkammer_diffmenge_einh_id )   AS  zu_schwer_durch_zu leicht
 
,v01.wrg_id
,v100.default_wrg 
,v04.menge_basis
,v04.komponentenmenge

FROM dbp_view.v_flw_bew_2 v01

--Prüfen, ob es in der Tabelle die transport_einheit_id gibt, nur dann die in_art_id ändern
LEFT JOIN (SELECT
transport_einheit_id
FROM dbp_view.v_flw_rauchverlust_2
GROUP BY transport_einheit_id) v02
ON v01.transport_einheit_id = v02.transport_einheit_id

--über den Auftrag das Auftragsmaterial ermitteln für nächsten Step
LEFT OUTER JOIN  dbp_view.v_flw_auftrag_pps_2 v03
ON v01.auftrag_id = v03.auftrag_id
AND v01.mandant_id = v03.mandant_id

--menge_basis und komponentenmenge aus der Stückliste ermitteln (mit diesen kann aus Istmenge die Sollmenge errechnet werden)
--dazu mit Werk und Auftragsmaterial (output) in die STKO_2 und menge_basis ermitteln
--über den Tabellenschlüssel (stueckliste_id, stueckliste_typ_id) in die STPO_2 und die komponentenmenge ermitteln
--diese wiederum auf die Inputmaterialien aufteilen
LEFT OUTER JOIN
(
SELECT
  v01.mandant_id
, v01.werk_id
, v01.flw_art_id AS flw_art_id_out	--Auftragsmaterial
, v02.flw_art_id AS flw_art_id_in	--dafür benötige Inputmaterialien
, SUM(v01.menge_basis) AS menge_basis
, SUM(v02.komponentenmenge) AS komponentenmenge

-- MAST_2/STKO_2
FROM dbp_view.v_flw_stueckliste_2 v01
-- STPO_2
JOIN dbp_view.v_flw_stueckliste_det_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.stueckliste_id = v02.stueckliste_id
AND v01.stueckliste_typ_id = v02.stueckliste_typ_id

WHERE v02.stueckliste_typ_id <> 'X'
AND v02.komponentenmenge <> 0.001
GROUP BY   v01.mandant_id
, v01.werk_id
, v01.flw_art_id 
, v02.flw_art_id 
) v04
ON v01.mandant_id = v04.mandant_id
AND v01.werk_id = v04.werk_id
AND v01.flw_art_id = v04.flw_art_id_in
AND v03.flw_art_id = v04.flw_art_id_out


JOIN dbp_view.v_mandant_2 v100
ON v01.mandant_id = v100.mandant_id

) dt1
;