clc
load fisheriris

species_names = string(species);

Flowers = zeros(150,1);
for index = 1:150
    flower_array(index,1) = Flower(meas(index,1), meas(index,2), meas(index,3), meas(index,4), species_names(index,1));
end

y = getSWidth(flower_array(30,1));
z = report(flower_array(30,1));
disp(z)