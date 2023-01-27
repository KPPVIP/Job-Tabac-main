INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_redwood', 'Redwood', 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_redwood', 'Redwood', 1);

INSERT INTO `jobs` (`name`, `label`) VALUES
('redwood', 'Redwood');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('redwood', 0, 'recrue', 'Recrue', 25, '', ''),
('redwood', 1, 'expe', 'Expérimenté', 55, '', ''),
('redwood', 2, 'tabac', 'Tabagiste', 65, '', ''),
('redwood', 3, 'chfp', 'Chef de projet', 85, '', ''),
('redwood', 4, 'boss', 'Gérant', 200, '', '');


INSERT INTO `items` (name, label, `limit`) VALUES

('tabac_blond', 'Tabac Blond', 35),

('tabac_brun', 'Tabac Brun', 35),

('blond_seche', 'Tabac Blond séché', 50),

('brun_seche', 'Tabac Brun séché', 50),

('marlboro', 'Marlboro', 12),

('gitanes', 'Gitanes', 12),

('truelle', 'Truelle', 1);