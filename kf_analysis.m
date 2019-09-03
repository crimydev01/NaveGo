function  kf_analysis (nav_e)
% kf_analysis: evaluates Kalman filter performance.
%
% INPUT
%   nav,  INS/GNSS dataset.
%
%   Copyright (C) 2014, Rodrigo Gonzalez, all rights reserved.
%
%   This file is part of NaveGo, an open-source MATLAB toolbox for
%   simulation of integrated navigation systems.
%
%   NaveGo is free software: you can redistribute it and/or modify
%   it under the terms of the GNU Lesser General Public License (LGPL)
%   version 3 as published by the Free Software Foundation.
%
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU Lesser General Public License for more details.
%
%   You should have received a copy of the GNU Lesser General Public
%   License along with this program. If not, see
%   <http://www.gnu.org/licenses/>.
%
% Reference:
%   Kalman filter tuning and consistency. ChM015x Sensor Fusion and Non-linear 
%   Filtering for Automotive Systems, section 4.3, course at www.edx.org. 
%
% Version: 001
% Date:    2019/09/02
% Author:  Rodrigo Gonzalez <rodralez@frm.utn.edu.ar>
% URL:     https://github.com/rodralez/navego


%% A POSTERIORI STATE ANALYSIS

variable = { 'roll', 'pitch', 'yaw', 'vel N', 'vel E', 'vel D', 'latitude', 'longitude', 'altitude' };

for i=1:9
    
    [pd, ha] = normality_test ( nav_e.xp (:, i) );
    
    figure(i)
    plot_histogram (nav_e.xp (:, i), pd)
    
    if ~( ha )
        fprintf('kf_analysis: state vector for %s comes from a normal distribution.\n', variable{i});
        
    else
         fprintf('kf_analysis: %s analysis does not come from a normal distribution.\n', variable{i});
        
    end
end

%% INNOVATION ANALYSIS

variable = { 'vel N', 'vel E', 'vel D', 'latitude', 'longitude', 'altitude' };

for i=1:6
    
    [pd, ha] = normality_test ( nav_e.v (:, i) );
    
    figure(i+9)
    plot_histogram (nav_e.v (:, i), pd)
    
    if ~( ha )
        fprintf('kf_analysis: innovations for %s comes from a normal distribution.\n', variable{i});
        
    else
         fprintf('kf_analysis: innovations for %s does not come from a normal distribution.\n', variable{i});
        
    end
end


end