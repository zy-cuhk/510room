clc,clear all,close all;
tic;

%% generating room planes of interior environment
[house_facet,house_vertices,house_norm_vector]=house_stl_reading("bim_document/001_1.stl");
% house_stl_matplot(house_facet,house_vertices,house_norm_vector);

[room_facet,room_vertices,room_norm_vector]=vertices_processing(house_facet,house_vertices,house_norm_vector);
% room_stl_matplot(room_facet,room_vertices,room_norm_vector)

%% generating room planes 
% [room_plane_norm_vector,room_plane_edge_cell,room_plane_edge_centroid,room_plane_triangle_cell,room_plane_triangle_edge_cell]=room_planes_generation(room_facet,room_vertices,room_norm_vector);
data=load('data.mat','room_plane_norm_vector','room_plane_edge_cell','room_plane_edge_centroid','room_plane_triangle_edge_cell','room_plane_triangle_cell');
room_plane_norm_vector1=data.room_plane_norm_vector;
for i=1:1:size(room_plane_norm_vector1,2)
    n1=room_plane_norm_vector1{i}(1,1);
    n2=sign(room_plane_norm_vector1{i}(1,2))*sqrt(1-n1^2);
    n3=0;
    room_plane_norm_vector{i}(1,1)=n1;
    room_plane_norm_vector{i}(1,2)=n2;
    room_plane_norm_vector{i}(1,3)=n3;
end


room_plane_edge_cell=data.room_plane_edge_cell;
room_plane_edge_centroid=data.room_plane_edge_centroid;
room_plane_triangle_edge_cell=data.room_plane_triangle_edge_cell;
room_plane_triangle_cell=data.room_plane_triangle_cell;

%% generating renovation and mobile base planes 
painting_gun_to_wall_distance=0.34;
distance_from_painting_gun=0.32;
panning_distance1=painting_gun_to_wall_distance+distance_from_painting_gun;
[renovation_plane_edge_cell,renovation_plane_norm_vector,renovation_plane_triangle_edge_cell]=room_panning_planes_generation(room_plane_norm_vector,room_plane_edge_cell,room_plane_triangle_edge_cell,panning_distance1);
panning_distance2=1.26;
[mobilebase_plane_edge_cell,mobilebase_plane_norm_vector,mobilebase_plane_triangle_edge_cell]=room_panning_planes_generation(room_plane_norm_vector,room_plane_edge_cell,room_plane_triangle_edge_cell,panning_distance2);
renovation_planes_visualization(room_plane_edge_cell, renovation_plane_edge_cell,mobilebase_plane_edge_cell);

%% generating renovation waypoints and waypaths
waypoints_interval=0.050;path_interval=0.250;
[renovation_effective_waypoints,renovation_effective_waypaths,room_plane_boundary]=renovation_planes_waypoint_generation(room_plane_edge_cell,room_plane_norm_vector,room_vertices,room_plane_triangle_cell,waypoints_interval,path_interval,panning_distance1);
renovation_planes_waypoint_visualization(renovation_effective_waypoints,room_plane_edge_cell,renovation_plane_edge_cell,renovation_effective_waypaths);


%% generating renovation cells containing waypaths 
cell_length=0.55;
cell_width=1.25;
% [renovation_cells_clustering_waypaths,renovation_cells_waypioints_onwaypath,renovation_cells_manipulatorbase_positions, manipulator_endeffector_positions_onpath]=renovation_cells_generation(room_plane_edge_cell,renovation_plane_edge_cell,mobilebase_plane_norm_vector,renovation_effective_waypaths,renovation_plane_norm_vector,cell_length,cell_width,path_interval);
% renovation_cells_waypath_visualization(renovation_cells_waypioints_onwaypath,renovation_cells_manipulatorbase_positions,renovation_plane_edge_cell,room_plane_edge_cell);



toc;


