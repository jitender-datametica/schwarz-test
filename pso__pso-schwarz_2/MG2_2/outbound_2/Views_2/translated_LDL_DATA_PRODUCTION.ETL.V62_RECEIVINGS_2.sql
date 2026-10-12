CREATE OR REPLACE VIEW ldl_data_production_etl.v62_receivings_2 (id, ctrcode, wh_nr, artikelnr, weposart, posnr,
link_posnr, mengekarton, mengestueck, decimalcase, tgstatus, entrydate, wekopfkrednr, lieferscheinnr, issue_slip,
satas_entree, po_nr, wekopfstatus, statussatz, wekopftgstatus, weight_value, pricecond_value, wedatum, wareneingangszeit
, we_art, adjust_stock, anlieferungsartkzl, bediener, item_facilty, rcv_unit_type, pallet_factor, container_deposit,
dayenddate, delnotenorm, dispolfdnrartikel, ekpstueckdm, ekpstueckekland, ekpstueckland, krednr, landkzl,
mindesthaltbarkeit, mwstschl, nr, oldstatus, ra_id, ra_posnr, rechposnr, ret_vatmultiplier, item_category, status_2,
sumekpdm, sumekpekland, sumekpland, sumvkpnorm, teillieferung, todo, vkpnormstueck, waehrungsknz_2, wekorrdatum, zollnr,
gesellschaftsnr, lagerortnr, includemargin, matchable, spcondnr, change_id, splitlinkposnr, split_type, valid_from,
valid_until, totalqty, sumret_vatvalue, ret_vatvalue, sum_contdeposit, ret_cd, sumret_cd, ret_vatcdbev, sumret_vatcdbev
, ret_vatbevpcd, sumret_vatbevpcd, ret_vatcd, sumret_vatcd, bevtax, sumbevtax, sumret_exclvat) AS SELECT wk.id,
 wk.ctrcode,
 wk.wh_nr,
 wp.artikelnr,
 wp.weposart,
 wp.posnr,
 wp.link_posnr,
 wp.mengekarton,
 wp.mengestueck,
 wp.decimalcase,
 wp.tgstatus,
 IFNULL(wp.wekorrdatum, wp.wedatum) AS entrydate,
 wk.krednr AS wekopfkrednr,
 wk.lieferscheinnr,
 wk.issue_slip,
 wp.satas_entree,
 wk.po_nr,
 wk.status_2 AS wekopfstatus,
 wk.statussatz,
 wk.tgstatus AS wekopftgstatus,
 wp.weight_value,
 wp.pricecond_value,
 wk.wedatum,
 wk.wareneingangszeit,
 wk.we_art,
 wp.adjust_stock,
 wp.anlieferungsartkzl,
 wp.bediener,
 wp.item_facility AS item_facilty,
 wp.rcv_unit_type,
 wp.pallet_factor,
 wp.container_deposit,
 wp.datum AS dayenddate,
 wk.delnotenorm,
 wp.dispolfdnrartikel,
 wp.ekpstueckdm,
 wp.ekpstueckekland,
 wp.ekpstueckland,
 wp.krednr,
 wp.landkzl,
 wp.mindesthaltbarkeit,
 wp.mwstschl,
 wp.nr,
 wp.oldstatus,
 wp.ra_id,
 wp.ra_posnr,
 wp.rechposnr,
 wp.ret_vatmultiplier,
 wp.item_category,
 wp.status_2,
 wp.sumekpdm,
 wp.sumekpekland,
 wp.sumekpland,
 wp.sumvkpnorm,
 wp.teillieferung,
 wp.todo,
 wp.vkpnormstueck,
 wp.waehrungsknz_2,
 wp.wekorrdatum,
 wp.zollnr,
 wk.gesellschaftsnr,
 wk.lagerortnr,
 wp.includemargin,
 wp.matchable,
 wp.spcondnr,
 wp.change_id,
 wp.splitlinkposnr,
 wp.split_type,
 wp.valid_from,
 wp.valid_until,
   wp.mengekarton * wp.decimalcase + IFNULL(wp.mengestueck, 0) AS totalqty,
   (wp.vkpnormstueck - wp.container_deposit - (wp.vkpnormstueck - wp.container_deposit) / NULLIF(CASE
       WHEN wp.ret_vatmultiplier IS NULL OR wp.ret_vatmultiplier = 0
       THEN 1
       ELSE wp.ret_vatmultiplier
       END, 0)) * (wp.mengekarton * wp.decimalcase + IFNULL(wp.mengestueck, 0)) AS sumret_vatvalue,
   wp.vkpnormstueck - wp.container_deposit - (wp.vkpnormstueck - wp.container_deposit) / NULLIF(CASE
     WHEN wp.ret_vatmultiplier IS NULL OR wp.ret_vatmultiplier = 0
     THEN 1
     ELSE wp.ret_vatmultiplier
     END, 0) AS ret_vatvalue,
  wp.container_deposit * (wp.mengekarton * wp.decimalcase + IFNULL(wp.mengestueck, 0)) AS sum_contdeposit,
  wp.vkpnormstueck - wp.container_deposit AS ret_cd,
   (wp.vkpnormstueck - wp.container_deposit) * (wp.mengekarton * wp.decimalcase + IFNULL(wp.mengestueck, 0)) AS
 sumret_cd,
    (wp.vkpnormstueck - wp.container_deposit) / NULLIF(CASE
     WHEN wp.ret_vatmultiplier IS NULL OR wp.ret_vatmultiplier = 0
     THEN 1
     ELSE wp.ret_vatmultiplier
     END, 0) / NULLIF(wp.bev_tax, 0) AS ret_vatcdbev,
     (wp.vkpnormstueck - wp.container_deposit) / NULLIF(CASE
      WHEN wp.ret_vatmultiplier IS NULL OR wp.ret_vatmultiplier = 0
      THEN 1
      ELSE wp.ret_vatmultiplier
      END, 0) / NULLIF(wp.bev_tax, 0) * (wp.mengekarton * wp.decimalcase + IFNULL(wp.mengestueck, 0)) AS sumret_vatcdbev
 ,
     (wp.vkpnormstueck - wp.container_deposit) / NULLIF(CASE
      WHEN wp.ret_vatmultiplier IS NULL OR wp.ret_vatmultiplier = 0
      THEN 1
      ELSE wp.ret_vatmultiplier
      END, 0) / NULLIF(wp.bev_tax, 0) + wp.container_deposit AS ret_vatbevpcd,
   ((wp.vkpnormstueck - wp.container_deposit) / NULLIF(CASE
        WHEN wp.ret_vatmultiplier IS NULL OR wp.ret_vatmultiplier = 0
        THEN 1
        ELSE wp.ret_vatmultiplier
        END, 0) / NULLIF(wp.bev_tax, 0) + wp.container_deposit) * (wp.mengekarton * wp.decimalcase + IFNULL(wp.mengestueck
     , 0)) AS sumret_vatbevpcd,
   (wp.vkpnormstueck - wp.container_deposit) / NULLIF(CASE
    WHEN wp.ret_vatmultiplier IS NULL OR wp.ret_vatmultiplier = 0
    THEN 1
    ELSE wp.ret_vatmultiplier
    END, 0) AS ret_vatcd,
    (wp.vkpnormstueck - wp.container_deposit) / NULLIF(CASE
     WHEN wp.ret_vatmultiplier IS NULL OR wp.ret_vatmultiplier = 0
     THEN 1
     ELSE wp.ret_vatmultiplier
     END, 0) * (wp.mengekarton * wp.decimalcase + IFNULL(wp.mengestueck, 0)) AS sumret_vatcd,
    (wp.vkpnormstueck - wp.container_deposit) / NULLIF(CASE
     WHEN wp.ret_vatmultiplier IS NULL OR wp.ret_vatmultiplier = 0
     THEN 1
     ELSE wp.ret_vatmultiplier
     END, 0) - (wp.vkpnormstueck - wp.container_deposit) / NULLIF(CASE
      WHEN wp.ret_vatmultiplier IS NULL OR wp.ret_vatmultiplier = 0
      THEN 1
      ELSE wp.ret_vatmultiplier
      END, 0) / NULLIF(wp.bev_tax, 0) AS bevtax,
   ((wp.vkpnormstueck - wp.container_deposit) / NULLIF(CASE
       WHEN wp.ret_vatmultiplier IS NULL OR wp.ret_vatmultiplier = 0
       THEN 1
       ELSE wp.ret_vatmultiplier
       END, 0) - (wp.vkpnormstueck - wp.container_deposit) / NULLIF(CASE
        WHEN wp.ret_vatmultiplier IS NULL OR wp.ret_vatmultiplier = 0
        THEN 1
        ELSE wp.ret_vatmultiplier
        END, 0) / NULLIF(wp.bev_tax, 0)) * (wp.mengekarton * wp.decimalcase + IFNULL(wp.mengestueck, 0)) AS sumbevtax,
   ((wp.vkpnormstueck - wp.container_deposit) / NULLIF(CASE
        WHEN wp.ret_vatmultiplier IS NULL OR wp.ret_vatmultiplier = 0
        THEN 1
        ELSE wp.ret_vatmultiplier
        END, 0) / NULLIF(wp.bev_tax, 0) + wp.container_deposit) * (wp.mengekarton * wp.decimalcase + IFNULL(wp.mengestueck
     , 0)) AS sumret_exclvat
FROM ldl_data_production_etl.t_wawi_precore_wepos_2 AS wp
 INNER JOIN ldl_data_production_etl.t_wawi_precore_wekopf_2 AS wk ON wp.id = wk.id AND wp.gesellschaftsnr = wk.gesellschaftsnr
     AND wp.lagerortnr = wk.lagerortnr;