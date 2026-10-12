CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AKTION_WERBEMENGEN_EINHOLUNG

AS
--30.07.2020 snik1809 AP0029549-SPEC0068832

SELECT
       mandant_id
      ,wup_id
      ,nb_id
      ,aktion_id
      ,wg_id
      ,arthiertyp_id
      ,schlagwort
      ,dat_von
      ,dat_bis
      ,dat_rueckmeldung
      ,dat_bis_rueckmeldung
      ,dat_aktionsbekanntmachung
      ,anzahl_artikel_offen
      ,anzahl_artikel_gesamt
      --,aktion_typ_id
      ,case when aktion_typ_id = 'ZAME' then 'AME' else 'WME' end as aktion_typ_id
      ,case 
       when ((status_einholung_id =2) OR ((status_einholung_id = 6) AND (dat_rueckmeldung < CURRENT_DATE)) OR  ((status_einholung_id = 9)  AND (dat_rueckmeldung < CURRENT_DATE) AND (status_einholung_markt_kz = ''))  AND (dat_bis >= CURRENT_DATE)) then 'Mengeneinholung'
       when (status_einholung_id = 9 AND status_einholung_markt_kz IN ('B', 'G')) then 'Bekanntmachung'
       else NULL
       end as status_einholung
   
FROM dbp_data.aktion_werbemengen_einholung;