CREATE OR REPLACE VIEW idq_production_eks_calculation.steks_translation_package_2 (translationid, checkid, pkid,
translation_fieldid, crdate, moddate, cruser, moduser, description) AS SELECT translationid,
 checkid,
 pkid,
 translation_fieldid,
 crdate,
 moddate,
 cruser,
 moduser,
 description
FROM idq_production_eks.translation_int_2
WHERE translation_fieldid = 10;