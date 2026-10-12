CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_STIMMIGKEIT
(stimmig_id,
stimmig_bez)
AS
   SELECT
   a01.stimmig_id,  a01.stimmig_bez
   FROM
   (SELECT
   '1' AS stimmig_id, 'nicht stimmig' AS stimmig_bez
   ) a01
   UNION
   SELECT
   a02.stimmig_id,  a02.stimmig_bez
   FROM
   (SELECT
   '0' AS stimmig_id, 'stimmig' AS stimmig_bez
   ) a02;