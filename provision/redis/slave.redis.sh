sudo apt update &&
echo "Setup Redis" &&
sudo apt install --no-install-recommends redis-server -y &&
sudo mv /etc/redis/redis.conf /etc/redis/default.redis.conf &&
sudo cp /vagrant/config/redis/slave.redis.conf /etc/redis/redis.conf &&
sudo chmod 0444 /etc/redis/redis.conf &&
sudo service redis restart &&
echo "Finish Setup Redis, try connect with: redis-cli -h <HOST> -a bdt"
