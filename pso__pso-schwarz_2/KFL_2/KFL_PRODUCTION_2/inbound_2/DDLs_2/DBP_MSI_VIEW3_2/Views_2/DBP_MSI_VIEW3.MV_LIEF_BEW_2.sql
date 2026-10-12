CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LIEF_BEW_2
(
 mandant_id
,wup_id
,nb_id
,dat_lief_soll
,dat_buch
,lief_beleg_id
,kj
,lagerbew_beleg_id
,lager_bewart_id
,wg_verkett_id
,lief_pal_typ_id
,versandstelle_id
,werbeware_id
,kunde_id
,mandant_id_kunde
,wrg_id
,wrg_typ_id
,menge_lief_ist_kolli
,anzahl_packstueck
,betrag_lagerbew
,betrag_vk_netto_vz
)
AS
-- 14.05.2018, AP0011752, srom0404 Anpassung Moldau, Filterung auf mandant_id <> 1 statt mandant_id IN (2,3,..)
-- 14.11.2019, AP0050464, nwag2310 Anpassung Moldau BEWART_2 643/644
-- 27.11.2019, AP0041558, nwag2310, added KJ in join (LIKP/LIPS)
-- 09.02.2021, AP0078007, SPEC0101516, srom0404, lief_pal_typ_id auf CHAR(2)
-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_2 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

SELECT
 t01.mandant_id
,t01.wup_id
,t01.nb_id
,t01.dat_lief_soll_
,t01.dat_buch
,t01.lief_beleg_id
,t01.kj
,t01.lagerbew_beleg_id
,t01.lager_bewart_id
,t01.wg_verkett_id
,t01.lief_pal_typ_id
,t01.versandstelle_id
,t01.werbeware_id
,t01.kunde_id_
,t01.mandant_id_kunde_
,t01.wrg_id
,t01.wrg_typ_id
,SUM(t01.menge_lief_ist_kolli) AS menge_lief_ist_kolli
,SUM(t01.anzahl_packstueck) AS anzahl_packstueck
,SUM(t01.betrag_lagerbew) AS betrag_lagerbew
,SUM(t01.betrag_vk_netto_vz) AS betrag_vk_netto_vz
FROM
(
SELECT
 v01.lief_beleg_id
,Cast(v01.lief_pal_typ_id AS VARCHAR(2)) AS lief_pal_typ_id
,v01.versandstelle_id
,v01.werbeware_id
,v01.kunde_id_
,v01.mandant_id_kunde_
,v01.mandant_id
,v01.wup_id
,v01.nb_id
,v01.dat_lief_soll_
,v01.ref_lagerbew_beleg_id_num
,v01.kj
,v01.lagerbew_beleg_id
,v01.dat_buch
,v01.lager_bewart_id
,v01.wg_verkett_id
,v01.wrg_id
,v01.wrg_typ_id
,SUM(v01.menge_lief_ist_kolli) AS menge_lief_ist_kolli
,MIN(v01.anzahl_packstueck) AS anzahl_packstueck
,SUM(CASE WHEN v01.wrg_typ_id = 0
          THEN (v01.betrag_lagerbew * v01.umrechnungskurs * v09.ek_anzeige_fg)
          ELSE (v01.betrag_lagerbew * v09.ek_anzeige_fg)
     END
     *
     CASE 
          -- Incident WOL3467619, Ergänzung der Storno- und Korrekturbuchungen (BWA 302;312;602;642;648)
          WHEN (v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648') AND v04_mandant_id <> 1)
          THEN -1
          ELSE 1
      END
    ) -- SUM
 AS betrag_lagerbew
,SUM(CASE WHEN v01.wrg_typ_id = 0
          THEN (v01.betrag_vk_netto_vz * v01.umrechnungskurs)
          ELSE v01.betrag_vk_netto_vz
     END
     *
     CASE
          -- Incident WOL3467619, Ergänzung der Storno- und Korrekturbuchungen (BWA 302;312;602;642;648)
          WHEN (v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648') AND v04_mandant_id <> 1)
          THEN -1
          ELSE 1
     END
    ) -- SUM
 AS betrag_vk_netto_vz

-- Das tbl Objekt ersetzt die bisherige Logik und materialisiert einen Join über mehrere Tabellen.
FROM dbp_msi_view3.tbl_mv_lief_bew_2 v01

JOIN dbp_msi_view3.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2  v10
ON v01.wrg_typ_id = v10.wrg_typ_id

CROSS JOIN dbp_msi.akt_msi_user_ek_anzeige_zu_2 v09

GROUP BY
 v01.lief_beleg_id
,v01.lief_pal_typ_id
,v01.versandstelle_id
,v01.werbeware_id
,v01.kunde_id_
,v01.mandant_id_kunde_
,v01.mandant_id
,v01.wup_id
,v01.nb_id
,v01. dat_lief_soll_
,v01.ref_lagerbew_beleg_id_num
,v01.kj
,v01.lagerbew_beleg_id
,v01.dat_buch
,v01.lager_bewart_id
,v01.wg_verkett_id
,v01.wrg_id
,v01.wrg_typ_id
) t01

GROUP BY
 t01.mandant_id
,t01.wup_id
,t01.nb_id
,t01.dat_lief_soll_
,t01.dat_buch
,t01.lief_beleg_id
,t01.kj
,t01.lagerbew_beleg_id
,t01.lager_bewart_id
,t01.wg_verkett_id
,t01.lief_pal_typ_id
,t01.versandstelle_id
,t01.werbeware_id
,t01.kunde_id_
,t01.mandant_id_kunde_
,t01.wrg_id
,t01.wrg_typ_id;