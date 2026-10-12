CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MONAT_3GJ_1
            (kjmo_buchungsschluss
            ,gj
            ,gj_vj_kz
            ,max_dat
            , kjmo_min
            , kjmo_max
            , gjmo_max
            )
            AS
               -- 20150219 kkaiser ANforderung # 610301, hier werden die 3 Vorjahre (GJ) zum Buchungsschluss ermittelt
               -- 20150422 - kkaiser Fehlerkorrektur, gjmo_max korrigiert

               SELECT
               kjmo_buchungsschluss,
               alles.gj,
               gj_vj_kz,
               CASE  WHEN alles.gj_vj_kz = 0       THEN  mgmax.dat_mo_ende
               ELSE  mmax.dat_mo_ende  END       AS max_dat,
               MIN(kjmo_min),
               MAX(kjmo_max),
               MAX(gjmo_max)
               FROM
               (
               SELECT
               CASE  WHEN m.akt_buchungs_schluss = 0 THEN  m.kjmo END  AS kjmo_buchungsschluss,
               m3j.gj,
               CASE  WHEN m3j.gj = m.gj       THEN  0
               WHEN m3j.gj = m.gj - 1 THEN -1
               WHEN m3j.gj = m.gj - 2 THEN -2
               WHEN m3j.gj = m.gj - 3 THEN -3  END       AS gj_vj_kz,
               101 AS max_dat,
               MIN(m3j.kjmo) over (partition by m3j.gj order by m3j.kjmo asc)   AS kjmo_min,
               MAX(m3j.kjmo) over (partition by m3j.gj order by m3j.kjmo asc)   AS kjmo_max,
               CASE WHEN gj_vj_kz < 0 THEN MAX(m3j.kjmo) over (partition by m3j.gj order by m3j.kjmo asc)
              WHEN gj_vj_kz = 0 THEN kjmo_buchungsschluss END
              AS gjmo_max
              FROM dbp_msi_view_ivs.mv_monat_1 m

               JOIN dbp_view.v_monat_1 m3j
               ON  m3j.gj  BETWEEN  m.gj - 3 AND m.gj
               AND  m.akt_buchungs_schluss = 0

               ) ALLES
               LEFT OUTER JOIN dbp_msi_view_ivs.mv_monat_1 mmax
               ON  alles.kjmo_max = mmax.kjmo
               LEFT OUTER JOIN dbp_msi_view_ivs.mv_monat_1 mgmax
               ON  alles.gjmo_max = mgmax.kjmo

               GROUP BY
               1,2,3,4;