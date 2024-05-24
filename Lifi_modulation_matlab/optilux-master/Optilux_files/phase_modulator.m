function Eout=phase_modulator( Ein, modsig)
%PHASE_MODULATOR modulate the optical field with a phase modulator
%   E=PHASE_MODULATOR(E,MODSIG) modulates the optical field E using a 
%   phase modulator. The parameter MODSIG is the electrical driving 
%   signal produced by ELECTRICSOURCE.
%   
%   See also MZ_MODULATOR, LASERSOURCE, ELECTRICSOURCE
%
%   Author: Marco Bertolini, 2009
%   University of Parma, Italy

%    This file is part of Optilux, the optical simulator toolbox.
%    Copyright (C) 2009  Paolo Serena, <serena@tlc.unipr.it>
%			 
%    Optilux is free software; you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation; either version 3 of the License, or
%    (at your option) any later version.
%
%    Optilux is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.

Eout = mz_modulator(Ein,modsig,struct('exratio',0,'nochirp',0));
