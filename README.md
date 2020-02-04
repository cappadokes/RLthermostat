# RLthermostat
My master's thesis project. The function of an [HVAC][wiki] thermostat controlling the temperature in a single room is simulated. The control algorithm employed is [Neural Fitted Q-iteration][nfq], and was implemented in Matlab. For a more formal presentation, the reader may refer to the relevant [paper][acm].

### Down the memory lane
Under the supervision of [Prof. Dimitrios Soudris][PDS], I started my thesis project in March 2017, and defended it in October of the same year. For a taste of what the project was about, you can check the thesis abstract, pasted below:

>Most contemporary thermostats are manually regulated from the user. This results to non-beneficial function cost, since nobody takes the many different parameters regulating energy consumption into consideration, instead focusing in maximizing their thermal comfort—at which maximum hardly ever do they get with the first try, thus resolving in costly temperature fluctuations.      In recent years, a new kind of thermostats has arisen. Under the name of smart thermostats, these devices employ techniques such as machine learning in order to deduce each consumer’s preferences and habits, and produce their setpoints of function in an autonomous and optimal (as regards energy consumption and thermal comfort) way. The smart thermostats movement is complemented by a broader effort of the scientifc community to effectively control heating, ventilation and air-conditioning (HVAC) systems. This is a hard poblem in respect of finding a general solution, since energy consumption and thermal comfort are not only comflicting quantities, but they also depend on each building’s architecture and usage purpose, the HVAC system’s type, and stochastic variables like occupancy and weather. The purpose of this thesis is to describe and evaluate, via simulation, the prototype of a universally applicable smart thermostat demonstrating polymorphic behavior. A computationally lightweight, model-free reinforcement learning algorithm is used. The user can set the tradeoff between consumption and comfort. The thermostat then produces a constantly self-refining behavior, accordingly optimizing the aforementioned quantities. Realization on embedded microcontroller platforms of minimal cost is supported.

This repository is by no means product-grade, and rather serves a solely archival purpose. You are always welcome, however, to [contact me][mail] for anything about the project that is of interest to you.

[PDS]: <https://microlab.ntua.gr/academics/dimitrios-soudris/>
[acm]: <https://dl.acm.org/doi/abs/10.1145/3285017.3285024>
[wiki]: <https://en.wikipedia.org/wiki/Heating,_ventilation,_and_air_conditioning>
[nfq]: <https://ml.informatik.uni-freiburg.de/former/_media/publications/rieecml05.pdf>
[mail]: <mailto:clabrakos@gmail.com>
