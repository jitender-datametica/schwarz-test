--13.02.2025
DROP TABLE IF EXISTS DBP_ETL.art_wup_autodispo_flw_gp_temp_2;

CREATE TABLE DBP_ETL.art_wup_autodispo_flw_gp_temp_2 
( mandant_id BYTEINT, gp_id INTEGER);
 
INSERT INTO DBP_ETL.art_wup_autodispo_flw_gp_temp_2 
SELECT mandant_id, gp_id 
FROM dbp_data.gp_2 WHERE gp_id IN (6912,6922,6916) AND mandant_id = 1;

--
DROP TABLE IF EXISTS DBP_ETL.art_wup_autodispo_flw_tag_temp_2;

CREATE TABLE DBP_ETL.art_wup_autodispo_flw_tag_temp_2  (
      mandant_id BYTEINT NOT NULL,
      kunde_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id_kunde SMALLINT NOT NULL,
      nb_id_lieferant SMALLINT NOT NULL,
      art_id INTEGER NOT NULL,
      dat DATE NOT NULL,
      we_bearbeitungszeit SMALLINT,
      planlieferzeit SMALLINT,
      kdis BYTEINT,
      verkaufslistung_fg BYTEINT,
      sa_af_fg BYTEINT,
      udf_prognose_menge_ungesteuert DECIMAL(13,3),
      udf_prognose_menge_gesteuert DECIMAL(13,3),
      fur_prognose_menge_ungesteuert DECIMAL(13,3),
      fur_prognose_menge_gesteuert DECIMAL(13,3),
      fur_prognose_menge_max DECIMAL(13,3),
      menge_abverkauf DECIMAL(13,3),
      ret_bestand DECIMAL(13,3),
      fur_bestand DECIMAL(13,3),
      menge_we_offen DECIMAL(13,3),
      menge_bv DECIMAL(13,3),
      menge_ofc DECIMAL(13,3),
      nullbestand_fg BYTEINT,
      menge_preisabschriften DECIMAL(13,3),
      menge_totalabschriften DECIMAL(13,3),
      kollifaktor DECIMAL(13,3),
      egalisierungsfaktor DECIMAL(18,7),
      menge_einh_id CHAR(3) COLLATE 'en-ci',
      servicelevel DECIMAL(5,2),
      optik DECIMAL(19,6),
      menge_we DECIMAL(13,3),
      basismenge_einh_id CHAR(3) COLLATE 'en-ci',
      vk_brutto DECIMAL(9,3),
      umrech_faktor_marm DECIMAL(18,7),
      umrech_faktor_ef DECIMAL(18,7),
      wg_id SMALLINT,
      bezugsvorschrift_kz CHAR(1) COLLATE 'en-ci',
      marc_kdis BYTEINT DEFAULT -1,
      marc_dat_von DATE,
      ordersatz_dat_von DATE,
      vklist_dat_von DATE,
      vklist_anz_schliesstage SMALLINT,
      bewart_id_fg CHAR(2) COLLATE 'en-ci',
      nullbestand_exc_fg BYTEINT DEFAULT 0,
      art_id_display INTEGER,
      menge_we_geplant DECIMAL(38,3),
      komponentenmenge DECIMAL(38,4),
      best_anz_schliesstage INTEGER,
      dat_best DATE )
;

INSERT INTO DBP_ETL.art_wup_autodispo_flw_tag_temp_2 (
        mandant_id,
        kunde_id,
        wup_id,
        nb_id_kunde,
        nb_id_lieferant,
        art_id,
        dat,
        basismenge_einh_id,
        vk_brutto,
        umrech_faktor_marm,
        umrech_faktor_ef,
        kollifaktor,
        wg_id,
        marc_kdis,
        marc_dat_von,
        sa_af_fg
)
SELECT  DISTINCT
        eord.mandant_id,
        eord.wup_id as kunde_id,
        eord.vz_wup_id as wup_id,
        eord.nb_id as nb_id_kunde,
        -111 nb_id_lieferant,
        eord.art_id,
        tag.dat,
        mara.basismenge_einh_id,
        vkbr.vk_brutto,
        marm.umrech_faktor umrech_faktor_marm,
        ef.umrech_faktor umrech_faktor_ef,
        kolli.faktor_kolli,
        wg.wg_id,
        marc.kdis as marc_kdis,
        marc.dat_von as marc_dat_von,
        0 as sa_af_fg                               
FROM    DBP_DATA.ek_orderbuch_2 eord_2                  -- ek_orderbuch_2
  CROSS JOIN DBP_DATA.tag_2 tag_2                       -- tag_2
  JOIN  DBP_DATA.art_2 mara_2                           -- mara_2
        ON eord.mandant_id = mara.mandant_id 
            and eord.art_id = mara.art_id
  JOIN  DBP_DATA.art_wup_zu_per_2 vkbr                -- art_wup_zu_per_2
        ON vkbr.mandant_id=eord.mandant_id 
            and vkbr.art_id=eord.art_id 
            and vkbr.wup_id=eord.wup_id 
            and tag.dat between vkbr.dat_von and vkbr.dat_bis
  JOIN  DBP_DATA.art_umrechnung_faktor_per_2 marm_2     -- art_umrechnung_faktor_per_2
        ON marm.mandant_id = mara.mandant_id 
            and marm.art_id=mara.art_id
            and tag.dat between marm.dat_von and marm.dat_bis 
            and marm.gew_einh_id = 'KG'
            and marm.altnv_menge_einh_id ='ST'
  JOIN  DBP_DATA.art_umrechnung_faktor_per_2 ef       -- art_umrechnung_faktor_per_2
        ON ef.mandant_id=eord.mandant_id 
            and ef.art_id=eord.art_id 
            and tag.dat between ef.dat_von and ef.dat_bis
            and ef.altnv_menge_einh_id = 'KG'       -- KG/KG zur Umrechnung von ST-Artikeln
            and ef.gew_einh_id = 'KG'
  JOIN   (  SELECT  maw1.mandant_id,                -- Kolli_Faktor
                    tag.dat,
                    maw1.art_id, 
                    maw1.ausg_menge_einh_id AS einh_kolli, 
                    CASE WHEN (marm_kol.umrech_zaehler/marm_kol.umrech_nenner) is not null 
                        THEN (marm_kol.umrech_zaehler/marm_kol.umrech_nenner) 
                        ELSE 1 END AS faktor_kolli
            FROM    DBP_DATA.art_vorschlagswert_per_2 maw1_2
              CROSS JOIN DBP_DATA.tag_2 tag_2  
              LEFT OUTER JOIN DBP_DATA.art_umrechnung_faktor_per_2 marm_kol 
		            ON tag.dat between marm_kol.dat_von and marm_kol.dat_bis
		                AND maw1.ausg_menge_einh_id=marm_kol.altnv_menge_einh_id 
		                AND marm_kol.mandant_id=maw1.mandant_id 
		                AND marm_kol.art_id=maw1.art_id
            WHERE   tag.dat between maw1.dat_von and maw1.dat_bis
              AND   tag.dat between ${DAT_VON} and ${DAT_BIS}
              --AND   tag.dat between '2020-05-05' and '2020-06-07'
         )kolli
         ON eord.mandant_id=kolli.mandant_id 
            and eord.art_id=kolli.art_id       
            and tag.dat = kolli.dat
  JOIN  DBP_DATA.art_wg_zu_per_2 wg                   -- art_wg_zu_per_2          
        ON eord.mandant_id=wg.mandant_id 
            and eord.art_id=wg.art_id 
            and tag.dat between wg.dat_von and wg.dat_bis
            and wg.arthiertyp_id = 2
  JOIN  DBP_DATA.art_wup_status_per_2 marc_2            -- marc_2
        ON eord.mandant_id=marc.mandant_id 
            and eord.art_id=marc.art_id 
            and eord.wup_id=marc.wup_id
            and tag.dat between marc.dat_von and marc.dat_bis 
  JOIN DBP_ETL.art_wup_autodispo_flw_gp_temp_2 flw_gp --13.02.2025
        ON  eord.mandant_id = flw_gp.mandant_id
	AND  eord.gp_id = flw_gp.gp_id           
WHERE   --eord.GP_ID IN (6912,6922,6916) --13.02.2025
   tag.dat between eord.dat_von and eord.dat_bis
  --AND eord.mandant_id = 1  --13.02.2025
  AND eord.nb_id = 0
  AND   tag.dat between ${DAT_VON} and ${DAT_BIS}
  AND (eord.mandant_id, wg.wg_id) IN (SELECT mandant_id, wg_id FROM  dbp_data.wg_filter_zu_2 WHERE wg_filter_id = 51)
;

INSERT INTO dbp_etl.art_wup_autodispo_flw_tag_temp_2 (
        mandant_id,
        kunde_id,
        wup_id,
        nb_id_kunde,
        nb_id_lieferant,
        art_id,
        dat,
        basismenge_einh_id,
        --vk_brutto,
        umrech_faktor_marm,
        umrech_faktor_ef,
        kollifaktor,
        wg_id,
        --marc_kdis,
        --marc_dat_von,
        sa_af_fg, 
        art_id_display
)
SELECT  --DISTINCT
        ze1wbb06.mandant_id,
        ze1wbb06.wup_id as kunde_id,
        CASE WHEN ze1wbb06_vz.auslieferungsgruppe_id = 'DFV' THEN COALESCE(ze1wbb06_disp.gp_id, ze1wbb06.gp_id) ELSE ze1wbb06.gp_id END as wup_id, --ze1wbb06.gp_id as wup_id,
        ze1wbb06.nb_id as nb_id_kunde,
        -111 nb_id_lieferant,
        ze1wbb06.art_id,
        tag.dat,
        mara.basismenge_einh_id,
        --vkbr.vk_brutto, 
        1 umrech_faktor_marm, 
        1 umrech_faktor_ef,   
        CASE WHEN (marm_kol.umrech_zaehler/marm_kol.umrech_nenner) is not null 
            THEN (marm_kol.umrech_zaehler/marm_kol.umrech_nenner) 
            ELSE 1 END AS  faktor_kolli, 
        wg.wg_id,
        --marc.kdis as marc_kdis,
        --marc.dat_von as marc_dat_von,
        0 as sa_af_fg,
        MAX(ze1wbb06_disp.art_id) as art_id_display                               
FROM  DBP_DATA.art_gp_wup_dts_zu_per_2 ze1wbb06
  JOIN DBP_DATA.tag_2 tag_2      -- tag_2
       ON tag.dat between ze1wbb06.dat_von and ze1wbb06.dat_bis
     JOIN DBP_DATA.art_wg_zu_per_2 wg   -- art_wg_zu_per_2 
       ON ze1wbb06.mandant_id=wg.mandant_id
          and ze1wbb06.art_id=wg.art_id
          and tag.dat between wg.dat_von and wg.dat_bis
          and wg.arthiertyp_id = 2
    JOIN DBP_DATA.wg_per_2 wg_per_2
       ON wg_per.mandant_id=wg.mandant_id
          and wg_per.wg_id=wg.wg_id
          and tag.dat between wg_per.dat_von and wg_per.dat_bis 
          and wg_per.arthiertyp_id = 2
  JOIN DBP_DATA.owg_per_2 owg_per_2
       ON wg_per.mandant_id=owg_per.mandant_id
          and wg_per.owg_id=owg_per.owg_id
          and tag.dat between owg_per.dat_von and owg_per.dat_bis 
          and owg_per.arthiertyp_id = 2
          --and owg_per.hwg_id IN (60,61,64)
  JOIN DBP_DATA.art_2 mara_2     -- mara_2
       ON ze1wbb06.mandant_id = mara.mandant_id
          and ze1wbb06.art_id = mara.art_id
  /* JOIN DBP_DATA.art_wup_zu_per_2 vkbr    -- art_wup_zu_per_2
       ON vkbr.mandant_id=ze1wbb06.mandant_id
          and vkbr.art_id=ze1wbb06.art_id
          and vkbr.wup_id=ze1wbb06.wup_id
          and tag.dat between vkbr.dat_von and vkbr.dat_bis */
  JOIN dbp_data.art_vorschlagswert_per_2 maw1_2
       ON maw1.mandant_id=mara.mandant_id
          and maw1.art_id=mara.art_id
          and tag.dat between maw1.dat_von and maw1.dat_bis
/* JOIN DBP_DATA.art_wup_status_per_2 marc_2  -- marc_2
       ON ze1wbb06.mandant_id=marc.mandant_id
          and ze1wbb06.art_id=marc.art_id
          and ze1wbb06.wup_id=marc.wup_id
          and tag.dat between marc.dat_von and marc.dat_bis */
  LEFT JOIN dbp_data.art_umrechnung_faktor_per_2 marm_kol
            ON tag.dat between marm_kol.dat_von and marm_kol.dat_bis
               and maw1.ausg_menge_einh_id=marm_kol.altnv_menge_einh_id
               and marm_kol.mandant_id=maw1.mandant_id
               and marm_kol.art_id=maw1.art_id
  LEFT JOIN DBP_DATA.stueckliste_det_2 stpo_2 
            ON ze1wbb06.mandant_id = stpo.mandant_id 
               AND ze1wbb06.art_id=stpo.art_id 
               AND stpo.mandant_id=1
               AND tag.dat between stpo.dat_von AND stpo.dat_bis 
  LEFT JOIN DBP_DATA.stueckliste_2 mast_2
            ON mast.mandant_id = stpo.mandant_id 
               AND mast.stueckliste_id=stpo.stueckliste_id
  LEFT JOIN DBP_DATA.art_gp_wup_dts_zu_per_2 ze1wbb06_disp
            ON mast.mandant_id = stpo.mandant_id 
               AND mast.art_id=ze1wbb06_disp.art_id 
               AND ze1wbb06.wup_id=ze1wbb06_disp.wup_id
               AND tag.dat between ze1wbb06_disp.dat_von AND ze1wbb06_disp.dat_bis 
  LEFT JOIN DBP_DATA.art_gp_wup_dts_zu_per_2 ze1wbb06_vz
            ON ze1wbb06_vz.auslieferungsgruppe_id = 'DFV'
               AND stpo.mandant_id = ze1wbb06_vz.mandant_id
               AND ze1wbb06.art_id=ze1wbb06_vz.art_id
               AND ze1wbb06_disp.gp_id=ze1wbb06_vz.wup_id
               AND tag.dat between ze1wbb06_vz.dat_von AND ze1wbb06_vz.dat_bis

WHERE tag.dat between ${DAT_VON} and ${DAT_BIS}
  AND ze1wbb06.nb_id = 0
  AND NOT EXISTS (SELECT 1 FROM dbp_data.wg_filter_zu_2 wgf WHERE wg_filter_id = 51 AND ze1wbb06.mandant_id=wgf.mandant_id AND wgf.wg_id=wg.wg_id)
  AND ( ze1wbb06.auslieferungsgruppe_id <> 'VEN' OR ze1wbb06_vz.auslieferungsgruppe_id = 'DFV')
  AND ze1wbb06.loesch_fg=0
  AND owg_per.hwg_id IN (60,61,64)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13 --,14,15,16
;

UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 tmp
FROM DBP_DATA.art_wup_zu_per_2 vkbr  
SET VK_BRUTTO = vkbr.vk_brutto
WHERE vkbr.mandant_id=tmp.mandant_id
      and vkbr.art_id=tmp.art_id
      and vkbr.wup_id=tmp.kunde_id
      and tmp.dat between vkbr.dat_von and vkbr.dat_bis
      and NOT EXISTS (SELECT 1 FROM dbp_data.wg_filter_zu_2 wgf WHERE wg_filter_id = 51 AND tmp.mandant_id=wgf.mandant_id AND wgf.wg_id=tmp.wg_id);

UPDATE dbp_etl.art_wup_autodispo_flw_tag_temp_2 tmp
FROM DBP_DATA.art_wup_status_per_2 marc_2  
SET marc_kdis=marc.kdis , marc_dat_von=marc.dat_von
WHERE marc.mandant_id=tmp.mandant_id
      and marc.art_id=tmp.art_id
      and marc.wup_id=tmp.kunde_id
      and tmp.dat between marc.dat_von and marc.dat_bis
      and NOT EXISTS (SELECT 1 FROM dbp_data.wg_filter_zu_2 wgf WHERE wg_filter_id = 51 AND tmp.mandant_id=wgf.mandant_id AND wgf.wg_id=tmp.wg_id);

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    bezugsvorschrift_kz = tbl.bezugsvorschrift_kz,
       ordersatz_dat_von = tbl.dat_von
FROM
(
SELECT  temp.mandant_id,
        temp.art_id,
        temp.kunde_id,
        temp.wup_id,
        temp.dat,
        temp.kdis,
        ordersatz.bezugsvorschrift_kz,
        ordersatz.dat_von
FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
  JOIN  (
          SELECT  mandant_id, 
                  wup_id,
                  art_id,
                  dat_von,
                  -- dat_bis immer auf dat_von des bereinigten nachfolgesatz -1 setzen, wenn kein nachfolger vorhanden = unendlich
                  -- korrektur 12.02.2021
                  --COALESCE(MAX(t011.dat_von -1 ) OVER (PARTITION BY t011.mandant_id ,t011.wup_id ,t011.art_id ORDER BY t011.dat_von ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) ,t011.dat_bis)  AS dat_bis_neu,
                  COALESCE(MAX(t011.dat_von -1 ) OVER (PARTITION BY t011.mandant_id ,t011.wup_id ,t011.art_id ORDER BY t011.dat_von ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) , DATE('9999-12-31'))  AS dat_bis_neu,
                  bezugsvorschrift_kz
          FROM     -- nur noch erster satz plus alle saetze mit aenderungen in der bezugsvorschrift:
                  ( SELECT mandant_id, wup_id, art_id, dat_von, dat_bis, bezugsvorschrift_kz
                     ,CASE WHEN t01.bezugsvorschrift_kz <>  
                        COALESCE( MAX(t01.bezugsvorschrift_kz) OVER (PARTITION BY t01.mandant_id,t01.wup_id ,t01.art_id   ORDER BY dat_von ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) , '0' ) 
                        then 1 else 0 end as chg_bezugsv
                    FROM DBP_DATA.art_wup_ordersatz_2 t01
                  ) t011
          WHERE chg_bezugsv = 1
        ) ordersatz
        ON temp.mandant_id=ordersatz.mandant_id 
            and temp.art_id=ordersatz.art_id 
            and temp.kunde_id=ordersatz.wup_id 
            and temp.dat between ordersatz.dat_von and ordersatz.dat_bis_neu
WHERE   ordersatz.bezugsvorschrift_kz is not null            
) AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    we_bearbeitungszeit = tbl.we_bearbeitungszeit,
       planlieferzeit = tbl.planlieferzeit
FROM
(
SELECT  distinct temp.mandant_id,
        temp.art_id,
        temp.kunde_id,
        temp.wup_id,
        temp.dat,
        storeterm.we_bearbeitungszeit,
        storeterm.planlieferzeit
FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
  JOIN  DBP_DATA.art_wup_status_per_2 marc_2 
        on temp.mandant_id=marc.mandant_id 
            and temp.art_id=marc.art_id 
            and temp.kunde_id=marc.wup_id
            and temp.dat between marc.dat_von and marc.dat_bis
  --needed for KMO to get auslieferungsgruppe_id
  LEFT JOIN (select mandant_id,
                    art_id,
                    wup_id,
                    gp_id,
                    auslieferungsgruppe_id,
                    dat_von,
                    dat_bis
             from dbp_data.art_gp_wup_dts_zu_per_2
             qualify row_number() over (partition by mandant_id,art_id,wup_id,gp_id order by dat_bis desc,auslieferungsgruppe_id) = 1) dts
  on temp.mandant_id = dts.mandant_id and 
     temp.art_id = dts.art_id and 
     temp.kunde_id = dts.wup_id and 
     temp.wup_id = dts.gp_id and 
     temp.dat between dts.dat_von and dts.dat_bis
  JOIN  DBP_DATA.wup_kunde_wg_disporhythmus_lft_zu_per_2 storeterm
        on temp.mandant_id=storeterm.mandant_id 
            and temp.wg_id=storeterm.wg_id 
            and temp.kunde_id=storeterm.kunde_id  
            and temp.wup_id = storeterm.wup_id
            and marc.terminierungsgruppe_1_id=storeterm.terminierungsgruppe_1_id
            and marc.terminierungsgruppe_2_id=storeterm.terminierungsgruppe_2_id
            and marc.terminierungsgruppe_3_id=storeterm.terminierungsgruppe_3_id
            and storeterm.sortimentslistenart_id=''
            --additional criteria for KMO/DE non-FLW:
            --and storeterm.auslieferungsgruppe_id = case when temp.mandant_id = 1 then storeterm.auslieferungsgruppe_id else dts.auslieferungsgruppe_id end 
            and storeterm.auslieferungsgruppe_id = case when temp.mandant_id = 1 and temp.wup_id in (6912,6922,6916) then storeterm.auslieferungsgruppe_id else dts.auslieferungsgruppe_id end
            and temp.dat between storeterm.dat_von and storeterm.dat_bis        
WHERE  storeterm.we_bearbeitungszeit is not null 
  OR   storeterm.planlieferzeit is not null 
) AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    we_bearbeitungszeit = coalesce(art_wup_autodispo_flw_tag_temp.we_bearbeitungszeit, tbl.we_bearbeitungszeit),
       planlieferzeit = coalesce(art_wup_autodispo_flw_tag_temp.planlieferzeit, tbl.planlieferzeit)
FROM
(
SELECT  temp.mandant_id,
        temp.art_id,
        temp.kunde_id,
        temp.wup_id,
        temp.dat,
        marc.we_bearbeitungszeit,
        marc.planlieferzeit
FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
  JOIN  DBP_DATA.art_wup_status_per_2 marc_2 
        on temp.mandant_id=marc.mandant_id 
            and temp.art_id=marc.art_id 
            and temp.kunde_id=marc.wup_id
            and temp.dat between marc.dat_von and marc.dat_bis    
) AS tbl
-- überschreiben mit Werte aus MARC_2 wenn NULL, sonst den bestehenden Wert übernehmen WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  where  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    fur_prognose_menge_ungesteuert = tbl.fur_prognose_menge_ungesteuert,
       fur_prognose_menge_gesteuert = tbl.fur_prognose_menge_gesteuert,
       fur_prognose_menge_max = tbl.fur_prognose_menge_max,
       menge_ofc = tbl.menge_ofc
FROM
(
SELECT  temp.mandant_id,
        temp.art_id,
        temp.kunde_id,
        temp.wup_id,
        temp.dat,
        fur.menge_prognose - fur.menge_prognose_bef as fur_prognose_menge_ungesteuert,
        fur.menge_prognose as fur_prognose_menge_gesteuert,
        fur.menge_prognose_max as fur_prognose_menge_max,
        fur.menge_ofc as menge_ofc
FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
  JOIN  DBP_DATA.fur_prognose_2 fur
        on temp.mandant_id = fur.mandant_id 
            and temp.art_id = fur.art_id
            and temp.kunde_id = fur.wup_id
            and temp.dat = fur.dat           
) AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    fur_bestand = case when tbl.bestand <= 0 then 0 else tbl.bestand end,
       optik = tbl.frp_mindestbestand,
       servicelevel = tbl.servicelevel,
       nullbestand_fg = case when fur_bestand <= 0 then 1 else 0 end
FROM
(
SELECT  temp.mandant_id,
        temp.art_id,
        temp.kunde_id,
        temp.wup_id,
        temp.dat,
        frp.bestand,
        frp.frp_mindestbestand,
        frp.servicelevel
FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
  JOIN  DBP_DATA.art_wup_frplauf_per_2 frp
        on temp.mandant_id=frp.mandant_id 
            and temp.art_id=frp.art_id 
            and temp.kunde_id=frp.wup_id
            and temp.dat between frp.dat_von and frp.dat_bis           
) AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    menge_bv = tbl.menge_best_vor * coalesce(kollifaktor,1)
FROM
(
SELECT  temp.mandant_id,
        temp.art_id,
        temp.kunde_id,
        temp.wup_id,
        temp.dat,
        sum(bv.menge_best_vor) menge_best_vor
FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
  JOIN  DBP_DATA.fur_best_vor_2 bv
        on temp.mandant_id=bv.mandant_id 
            and temp.art_id=bv.art_id 
            and temp.kunde_id=bv.wup_id 
            and temp.dat=bv.dat_dispo      
GROUP BY 1,2,3,4,5            
) AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    menge_we_offen = tbl.menge_einteil * coalesce(kollifaktor,1)
FROM
(
SELECT  temp.mandant_id,
        temp.art_id,
        temp.kunde_id,
        temp.wup_id,
        temp.dat,
        menge_einteil
FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
  JOIN (    SELECT  ekpo.mandant_id, ekpo.wup_id, ekpo.art_id, dat_lief_wunsch, sum(menge_einteil) as menge_einteil
            FROM    DBP_DATA.besch_best_det_2 ekpo_2 
              JOIN  DBP_DATA.lief_einteilung_2 eket
                    on eket.mandant_id=ekpo.mandant_id 
                       and ekpo.best_beleg_id = eket.best_beleg_id 
                       and ekpo.best_beleg_pos_id = eket.best_beleg_pos_id
                       and ekpo.loesch_fg = 0
                       and ekpo.endlief_fg = 0  -- neu: nur offene WE
            group by 1,2,3,4
        ) owe       
        on temp.mandant_id=owe.mandant_id 
            and temp.kunde_id=owe.wup_id
            and temp.art_id=owe.art_id
            and temp.dat = owe.dat_lief_wunsch           
) AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    menge_we = tbl.menge_lagerbew_bme
FROM
(
  SELECT  temp.mandant_id, 
          temp.kunde_id,
          temp.wup_id, 
          temp.art_id, 
          temp.dat, 
          sum(mseg.menge_lagerbew_bme) as menge_lagerbew_bme 
  FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
    JOIN  DBP_DATA.lagerbew_det_2 mseg 
          on temp.mandant_id = mseg.mandant_id
            and temp.kunde_id = mseg.wup_id
            and temp.art_id = mseg.art_id
            and temp.dat = mseg.dat_buch
    JOIN  DBP_DATA.lagerbew_2 mkpf 
          on mkpf.mandant_id=mseg.mandant_id 
            and mseg.lagerbew_beleg_id = mkpf.lagerbew_beleg_id 
            and mkpf.vorgangsart_id='WE' 
            and mkpf.dat_buch = mseg.dat_buch
    WHERE mseg.lager_bewart_id NOT IN ( SELECT  lager_bewart_id
                                        FROM    DBP_DATA.lager_bewart_spr_zu_2
                                        WHERE   (mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%') 
                                                OR (mandant_id > 1 AND lager_bewart_id = '641'))
    
  group by 1,2,3,4,5
) AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    menge_preisabschriften = tbl.menge_preisabschriften,
       menge_totalabschriften = tbl.menge_totalabschriften
FROM
(
  SELECT  temp.mandant_id, 
          temp.kunde_id,
          temp.wup_id, 
          temp.art_id, 
          temp.dat,
          sum(case when (temp.mandant_id=1 and abschriftart_id in (100,101,102,103,157,190))
                     then (case when abschrift_menge_einh_id = 'G' then menge_abschrift/1000 else menge_abschrift end) 
                   when (temp.mandant_id>1 and abschriftart_id in (973,974,905,906,983,984,971,972,987,988,993,994))
                     then (case when abschrift_menge_einh_id = 'G' then menge_abschrift/1000 else menge_abschrift end)
                    else 0 end
              ) as menge_totalabschriften,
          sum(case when (temp.mandant_id=1 and abschriftart_id in (5,7)) 
                     then (case when abschrift_menge_einh_id = 'G' then menge_abschrift/1000 else menge_abschrift end) 
                   when (temp.mandant_id>1 and abschriftart_id in (2,7,10,11))
                     then (case when abschrift_menge_einh_id = 'G' then menge_abschrift/1000 else menge_abschrift end)
              else 0 end) menge_preisabschriften 
  FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
    JOIN  DBP_DATA.marktabschriften_2 absch
          ON temp.mandant_id = absch.mandant_id
             and temp.kunde_id = absch.wup_id
             and temp.art_id = absch.art_id
             and temp.dat = absch.dat
    group by 1,2,3,4,5 
)  AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

--23.03.2023
UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    menge_preisabschriften = tbl.menge_preisabschriften
FROM
(
  SELECT  temp.mandant_id, 
          temp.kunde_id,
          temp.wup_id, 
          temp.art_id, 
          temp.dat,
          sum(menge_erf) menge_preisabschriften
  FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
    JOIN  DBP_DATA.art_umbewertung_2 absch
          ON temp.mandant_id = absch.mandant_id
             and temp.kunde_id = absch.wup_id
             and temp.art_id = absch.art_id
             and temp.dat = absch.dat_umbew
  WHERE (absch.mandant_id = 6 and preis_aend_grund_id = 2) 
        or (absch.mandant_id in (2,4,5,7,8) and preis_aend_grund_id = 7)
        or (absch.mandant_id = 3 and preis_aend_grund_id = 11)
     group by 1,2,3,4,5 
)  AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    ret_bestand = tbl.ret_bestand
FROM
(
  SELECT  temp.mandant_id, 
          temp.kunde_id,
          temp.wup_id, 
          temp.art_id, 
          temp.dat,
          mard.menge_lgbest_erp_frei_bme as ret_bestand
  FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
    JOIN DBP_DATA.marktbestand_erp_2 mard_2 --vor-vortag und davor
          on temp.mandant_id=mard.mandant_id 
            and temp.art_id=mard.art_id 
            and temp.kunde_id=mard.wup_id 
            and temp.dat -1 = mard.dat 
)  AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    sa_af_fg = 1
FROM
(
  SELECT  temp.mandant_id, 
          temp.kunde_id, 
          temp.art_id, 
          temp.dat
  FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
    JOIN  ( SELECT  wakp.mandant_id,
                    wakp.art_id,         
                    wakp.wup_id,
                    wakh.dat_von,
                    wakh.dat_bis
            FROM    DBP_DATA.aktion_2 wakh_2
              JOIN  DBP_DATA.aktion_art_wup_zu_2 wakp_2
                    ON wakh.mandant_id = wakp.mandant_id
                      and wakh.aktion_id = wakp.aktion_id
            WHERE -- ( wakh.preisaktiviert_fg = 1 OR wakh.dat_von > CURRENT_DATE ) and wakp.dat_sperrung is null
                  --24.01.2023 determination of promotion listings
                  ( wakh.mandant_id = 1 and wakh.preisaktiviert_fg = 1 and wakp.dat_sperrung is null )
                  OR  
                  ( wakh.mandant_id > 1 and wakp.dat_preisaktiviert <> '1900-01-01' and wakp.vk_aktion_brutto > 0 )
            GROUP BY 1,2,3,4,5
          ) as wak
          ON temp.mandant_id = wak.mandant_id
            and temp.art_id = wak.art_id
            and temp.kunde_id = wak.wup_id
            and temp.dat between wak.dat_von and wak.dat_bis
  GROUP    BY 1,2,3,4  
) AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    menge_abverkauf = tbl.menge_abverkauf
FROM
(
SELECT  temp.mandant_id,
        temp.art_id,
        temp.kunde_id,
        temp.wup_id,
        temp.dat,
        sum(menge) menge_abverkauf
FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
  JOIN  DBP_DATA.artbew_2 ab
        on temp.mandant_id=ab.mandant_id
            and temp.art_id=ab.art_id
            and temp.kunde_id=ab.wup_id
            and temp.dat = ab.dat
WHERE   ab.menge is not null
group by 1,2,3,4,5
) AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
 SET udf_prognose_menge_gesteuert = fur_prognose_menge_ungesteuert
 WHERE temp.dat < ${UDF_CUTOVER_DATE}       -- Wechsel der verwendeten Zeitreihe
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
-- not OK due to DBP_DATA.udf_prognose_2 changes ... on prod is still valid ... leave it like this for the moment
UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    udf_prognose_menge_gesteuert = tbl.menge_prognose
FROM
(
  SELECT  temp.mandant_id, 
          temp.kunde_id, 
          temp.wup_id, 
          temp.art_id, 
          temp.dat,
          sum(udf.menge_prognose_gesteuert) as menge_prognose
  FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
    JOIN  DBP_DATA.udf_prognose_2 udf
          on temp.mandant_id = udf.mandant_id
            and temp.art_id = udf.art_id
            and temp.kunde_id = udf.wup_id
            and temp.dat = udf.dat
            and udf.dat_prognoselauf = case when udf.dat < CURRENT_DATE then udf.dat else CURRENT_DATE-1 end
            WHERE udf.diagnose_id = ''
            AND udf.dat >= ${UDF_CUTOVER_DATE} -- Wechsel der verwendeten Zeitreihe
  GROUP BY 1,2,3,4,5
)  AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
-- not OK due to DBP_DATA.udf_prognose_2 changes ... on prod is still valid ... leave it like this for the moment
UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    udf_prognose_menge_gesteuert = tbl.menge_prognose
FROM
(
  SELECT  temp.mandant_id, 
          temp.kunde_id, 
          temp.wup_id, 
          temp.art_id, 
          temp.dat,
          sum(udf.menge_prognose_gesteuert) as menge_prognose
  FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
    JOIN  DBP_DATA.udf_prognose_2 udf
          on temp.mandant_id = udf.mandant_id
            and temp.art_id = udf.art_id
            and temp.kunde_id = udf.wup_id
            and temp.dat = udf.dat
            and udf.dat_prognoselauf = CURRENT_DATE
            WHERE udf.diagnose_id = ''
            AND udf.dat >= ${UDF_CUTOVER_DATE} -- Wechsel der verwendeten Zeitreihe
  GROUP BY 1,2,3,4,5
)  AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
-- not OK due to DBP_DATA.udf_prognose_2 changes ... on prod is still valid ... leave it like this for the moment
UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    udf_prognose_menge_ungesteuert = tbl.menge_prognose
FROM
(
  SELECT  temp.mandant_id, 
          temp.kunde_id, 
          temp.wup_id, 
          temp.art_id, 
          temp.dat,
          sum(coalesce(udf.menge_prognose_af,0) + coalesce(udf.menge_prognose_sa,0)) as menge_prognose
  FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
    JOIN  DBP_DATA.udf_prognose_2 udf
          on temp.mandant_id = udf.mandant_id
            and temp.art_id = udf.art_id
            and temp.kunde_id = udf.wup_id
            and temp.dat = udf.dat
            and udf.dat_prognoselauf = case when udf.dat < CURRENT_DATE then udf.dat else CURRENT_DATE-1 end
            WHERE udf.diagnose_id = ''
  GROUP BY 1,2,3,4,5
)  AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
-- not OK due to DBP_DATA.udf_prognose_2 changes ... on prod is still valid ... leave it like this for the moment
UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET    udf_prognose_menge_ungesteuert = tbl.menge_prognose
FROM
(
  SELECT  temp.mandant_id, 
          temp.kunde_id, 
          temp.wup_id, 
          temp.art_id, 
          temp.dat,
          sum(coalesce(udf.menge_prognose_af,0) + coalesce(udf.menge_prognose_sa,0)) as menge_prognose
  FROM    DBP_ETL.art_wup_autodispo_flw_tag_temp_2 temp
    JOIN  DBP_DATA.udf_prognose_2 udf
          on temp.mandant_id = udf.mandant_id
            and temp.art_id = udf.art_id
            and temp.kunde_id = udf.wup_id
            and temp.dat = udf.dat
            and udf.dat_prognoselauf = CURRENT_DATE
            WHERE udf.diagnose_id = ''
  GROUP BY 1,2,3,4,5
)  AS tbl WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = tbl.mandant_id
  and  art_wup_autodispo_flw_tag_temp.art_id = tbl.art_id
  and  art_wup_autodispo_flw_tag_temp.kunde_id = tbl.kunde_id
  and  art_wup_autodispo_flw_tag_temp.wup_id = tbl.wup_id
  and  art_wup_autodispo_flw_tag_temp.dat = tbl.dat
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2
SET     vklist_dat_von = coalesce(ordersatz_dat_von, marc_dat_von) + we_bearbeitungszeit + planlieferzeit
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2
SET     vklist_anz_schliesstage = (
          SELECT sum(anz_schliesstage) anz_schliesstage FROM 
          (
            SELECT mandant_id, wup_id, dat, offen, 1 as anz_schliesstage FROM DBP_DATA.wupcal_ereignis_zu_2 where offen=0
            UNION
            SELECT mandant_id, wup_id, dat, offen, 1 as anz_schliesstage FROM DBP_DATA.wupcal_2 where offen=0
          ) w
          WHERE art_wup_autodispo_flw_tag_temp.mandant_id = w.mandant_id
            and art_wup_autodispo_flw_tag_temp.kunde_id = w.wup_id
            and w.dat between coalesce(ordersatz_dat_von, marc_dat_von) and vklist_dat_von
        )
;

UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2
SET     kdis = case when bezugsvorschrift_kz = 'P' then 1 
                 when bezugsvorschrift_kz is NULL and marc_kdis = 1 then 1 
                 else 0 end,
        verkaufslistung_fg = 
                      case   -- verzögerung DIS um vorlauf (webaz+plifz+schliesstage)
                          when ((bezugsvorschrift_kz  <> 'P') or ( bezugsvorschrift_kz is null and marc_kdis = 0))
                              and dat < vklist_dat_von  + coalesce(vklist_anz_schliesstage,0) 
                          then 0
                          -- verlängerung über DIS hinaus
                          when (bezugsvorschrift_kz  = 'P' or ( bezugsvorschrift_kz is null and marc_kdis = 1))
                              and (vklist_dat_von + coalesce(vklist_anz_schliesstage,0) ) - dat <= 0 
                          then 0 
                          
                          else 1 end      
;

/*
UPDATE DBP_ETL.art_wup_autodispo_flw_tag_temp_2
SET    nullbestand_exc_fg = 1 
WHERE  (mandant_id, kunde_id, art_id, dat)
       IN (SELECT mandant_id, wup_id, art_id, dat_plan -1 as dat FROM DBP_DATA.ausnahme_2 WHERE pruef_id = 209);
*/

--SPEC0311196 13.05.2025
--inherit sales_2 listing + kdis from display
UPDATE DBP_ETL.art_wup_autodispo_flw_tag_temp_2
FROM
(
SELECT 
mandant_id mandant_id_, 
kunde_id kunde_id_, 
wup_id wup_id_,
art_id art_id_, 
dat dat_, 
kdis kdis_, 
verkaufslistung_fg verkaufslistung_fg_
FROM DBP_ETL.art_wup_autodispo_flw_tag_temp_2
) kdis
SET kdis = CASE WHEN kdis_ = 0 THEN kdis_ ELSE kdis END,
    verkaufslistung_fg = CASE WHEN verkaufslistung_fg_ = 1 THEN verkaufslistung_fg_ ELSE verkaufslistung_fg END
WHERE mandant_id = mandant_id_
AND kunde_id = kunde_id_
AND wup_id = wup_id_
AND art_id_display = art_id_
AND dat = dat_
;

/* remove on 20.01.2026
--SPEC0316315 11.06.2025 
UPDATE DBP_ETL.art_wup_autodispo_flw_tag_temp_2 f
SET f.menge_we_geplant =  
CASE 
WHEN ofc.dat_best < CURRENT_DATE then f.menge_we
WHEN ofc.dat_best = CURRENT_DATE then f.menge_we_offen
WHEN ofc.dat_best > CURRENT_DATE then COALESCE(f.menge_ofc,0) + COALESCE(f.menge_we_offen,0) 
END
FROM (
SELECT
mandant_id, 
wup_id, 
art_id, 
dat_best, 
dat_lief 
FROM dbp_data.order_forecast_2 
qualify row_number() over (partition by mandant_id, wup_id, art_id, dat_lief order by dat_plan desc)=1
) ofc
WHERE 
f.dat = ofc.dat_lief
AND f.mandant_id = ofc.mandant_id 
AND ofc.wup_id = f.kunde_id 
AND ofc.art_id = f.art_id 
;
*/

-- SPEC0320569 - 07.07.2025 add art_id_display / komponentenmenge
UPDATE DBP_ETL.art_wup_autodispo_flw_tag_temp_2
FROM (
SELECT mast.mandant_id as mandant_id_, stpo.art_id as art_id_, stpo.komponentenmenge as komponentenmenge_, stpo.komponentenmenge_einh_id,
mast.art_id as art_id_display_ , stpo.dat_von, stpo.dat_bis 
FROM DBP_DATA.stueckliste_det_2 stpo_2
     JOIN DBP_DATA.stueckliste_2 mast_2 ON stpo.mandant_id = mast.mandant_id AND stpo.stueckliste_id = mast.stueckliste_id
) stl
SET komponentenmenge = komponentenmenge_
WHERE mandant_id = mandant_id_
AND art_id = art_id_
AND art_id_display = art_id_display_
AND dat between dat_von and dat_bis;

UPDATE DBP_ETL.art_wup_autodispo_flw_tag_temp_2
FROM (
SELECT mandant_id_, art_id_display_, dat_ , sum(komponentenmenge) as komponentenmenge_sum 
FROM ( SELECT DISTINCT mandant_id as mandant_id_, art_id, art_id_display as art_id_display_ , dat as dat_ , komponentenmenge
       FROM DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
       WHERE art_id_display is not null
) stl_i
GROUP BY 1,2,3
) stl
SET komponentenmenge = komponentenmenge_sum
WHERE mandant_id = mandant_id_
AND art_id = art_id_display_
AND dat = dat_;

--21.08.2025
--number of closed days between order+delivery date
UPDATE DBP_ETL.art_wup_autodispo_flw_tag_temp_2
SET best_anz_schliesstage = (
          SELECT sum(anz_schliesstage) anz_schliesstage FROM 
          (
            SELECT mandant_id, wup_id, dat, offen, 1 as anz_schliesstage FROM DBP_DATA.wupcal_ereignis_zu_2 where offen = 0
            UNION
            SELECT mandant_id, wup_id, dat, offen, 1 as anz_schliesstage FROM DBP_DATA.wupcal_2 where offen=0
          ) w
          WHERE art_wup_autodispo_flw_tag_temp.mandant_id = w.mandant_id
                AND art_wup_autodispo_flw_tag_temp.kunde_id = w.wup_id
                --AND w.dat BETWEEN art_wup_autodispo_flw_tag_temp.dat - planlieferzeit - we_bearbeitungszeit AND art_wup_autodispo_flw_tag_temp.dat 
                --20.01.2026 change for best_anz_schliesstage -  we_bearbeitungszeit should not be deducted
                AND w.dat BETWEEN art_wup_autodispo_flw_tag_temp.dat - planlieferzeit AND art_wup_autodispo_flw_tag_temp.dat
        );


--set order date:
UPDATE DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET 
dat_best = CASE WHEN offen = 0 THEN NULL 
                ELSE art_wup_autodispo_flw_tag_temp.dat - planlieferzeit - COALESCE(best_anz_schliesstage,0) END

FROM  ( SELECT mandant_id, wup_id, dat, max(offen) as offen FROM (
          SELECT mandant_id, wup_id, dat, offen FROM DBP_DATA.wupcal_zukunft_2
          UNION
          SELECT mandant_id, wup_id, dat, offen FROM DBP_DATA.wupcal_2 ) group by 1,2,3
          )  w
        WHERE art_wup_autodispo_flw_tag_temp.mandant_id = w.mandant_id
              AND art_wup_autodispo_flw_tag_temp.kunde_id = w.wup_id
              AND art_wup_autodispo_flw_tag_temp.dat = w.dat ;

--menge_we_geplant = actual GR for the past and expected GR for the given day
UPDATE DBP_ETL.art_wup_autodispo_flw_tag_temp_2 f
SET f.menge_we_geplant = CASE 
                           WHEN dat < CURRENT_DATE THEN f.menge_we
                           WHEN dat >= CURRENT_DATE THEN f.menge_we_offen 
END;

--menge_we_geplant for order date = today onwards: expected GR + OFC
UPDATE  DBP_ETL.art_wup_autodispo_flw_tag_temp_2 
SET menge_we_geplant =  COALESCE(fur.menge_ofc,0) + COALESCE(menge_we_offen,0)
FROM DBP_DATA.fur_prognose_2 fur
WHERE  art_wup_autodispo_flw_tag_temp.mandant_id = fur.mandant_id
  AND art_wup_autodispo_flw_tag_temp.art_id = fur.art_id
  AND art_wup_autodispo_flw_tag_temp.kunde_id = fur.wup_id
  AND art_wup_autodispo_flw_tag_temp.dat_best = fur.dat
  AND art_wup_autodispo_flw_tag_temp.dat_best >= CURRENT_DATE
;
