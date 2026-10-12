--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.mis_q_kunden_1  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL,
      dat DATE NOT NULL,
      dat_vgl DATE NOT NULL,
      bonanzahl INTEGER NOT NULL,
      Kunden_fg BYTEINT NOT NULL,
      KundenAvg_fg BYTEINT NOT NULL,
      Kundengleich_fg BYTEINT NOT NULL
       )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.mis_q_kunden_1
(
      mandant_id
      ,wup_id
      ,nb_id
      ,dat
      ,dat_vgl
      ,Kundengleich_fg
      ,KundenAvg_fg
      ,Kunden_fg
      ,bonanzahl
)
SELECT
      t1.mandant_id
      ,t1.wup_id
      ,t1.nb_id
      ,t2.dat
      ,t2.dat_vgl
      ,t2.Kundengleich_fg
      ,t2.KundenAvg_fg
      ,t2.Kunden_fg
      ,t1.Bonanzahl
FROM
  DBP_DATA.wupcal_1 t1_1
INNER JOIN
  DBP_ETL.mis_q_kunden_join_tag_1 t2
ON
  t1.mandant_id=t2.mandant_id
AND
  t1.wup_id=t2.wup_id
AND
  t1.nb_id=t2.nb_id
AND
  t1.dat=t2.dat_vgl

---aalb, workaround aufgrund Abbruch am 16.05.2014---
WHERE  t1.Bonanzahl IS NOT NULL
;

