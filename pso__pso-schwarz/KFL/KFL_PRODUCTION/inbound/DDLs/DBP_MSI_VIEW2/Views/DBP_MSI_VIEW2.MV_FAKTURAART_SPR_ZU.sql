CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_FAKTURAART_SPR_ZU
(
mandant_id
, fakturaart_id
, spr_id
, fakturaart_bez
, f_soll_haben
)
AS
   SELECT
   mandant_id, fakturaart_id, spr_id, fakturaart_bez, CASE WHEN fakturaart_id in ('ZIVS', 'S1', 'ZLG2', 'G2', 'ZLRE','ZLIG','ZLLS','ZLUS') THEN '-' ELSE '+' END
   FROM dbp_view.v_fakturaart_spr_zu
   WHERE spr_id=22 AND fakturaart_id in ('G2', 'L2', 'S1', 'S2','ZF1','ZIV', 'ZIVS','ZLF2', 'ZLG2','ZLIG',
   'ZLL2','ZLLS', 'ZLRE', 'ZLRS','ZLS2','ZLUL','ZLUS')
   AND mandant_id = 1;