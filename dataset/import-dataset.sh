echo "Setup MySQL Steam DB" &&
sudo cp /vagrant/dataset/steam-games.csv /var/lib/mysql-files/steam-games.csv &&
sudo chmod 0444 /var/lib/mysql-files/steam-games.csv &&
sudo mysql -e "
  CREATE DATABASE steam;
  USE steam;

  CREATE TABLE games (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    release_date date NOT NULL,
    price varchar(255) NOT NULL,
    PRIMARY KEY (id)
  );

  LOAD DATA INFILE '/var/lib/mysql-files/steam-games.csv'
  INTO TABLE games
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (name, @release_date, price)
  SET release_date = STR_TO_DATE(@release_date, '%m-%d-%Y');
" &&
echo "Finish Setup MySQL Steam DB, try connect with: mysql -h <HOST> -u bdt -pbdt steam"
