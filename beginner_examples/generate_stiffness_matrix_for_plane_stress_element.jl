# This file is a part of JuliaFEM.
# License is MIT: see https://github.com/JuliaFEM/JuliaFEM.jl/blob/master/LICENSE.md

# # Generating local matrices for problems

using JuliaFEM

# Plane stress Quad4 element with linear material model:

# In JuliaFEM the plane stress element can be defined using Quad4 element which
# has four nodes. First we need to define geometry. Geometry is defined with
# node number and coordinates into a dictionary.

X = Dict(1 => [0.0, 0.0],
         2 => [2.0, 0.0],
         3 => [2.0, 2.0],
         4 => [0.0, 2.0])

# Element is created using Element(element_type, connectivity) -function. Here
# we create a Quad4 element which is connected to nodes 1-4.

element = Element(Quad4, [1, 2, 3, 4])

# Element properties are defined using update!(element, field, value) -function.
# To create stiffness matrix we need to define geometry, Young's modulus and
# Poisson's ratio.

update!(element, "geometry", X)
update!(element, "youngs modulus", 288.0)
update!(element, "poissons ratio", 1/3)

# Then we have to create a problem using
# Problem(problem_type, name, number_of_dofs_per_node) -function. Problem type
# in this case is Elasticity and number of dofs per node is two in 2D problem.
# In the problem.properties.formulation we must define whether we are using
# :plane_stress or :plane_strain formulation.

problem = Problem(Elasticity, "example elasticity problem", 2)
problem.properties.formulation = :plane_stress

# Elements need to added to the problem using add_elements!(problem, element)
# -function.

add_elements!(problem, [element])

# Normally next thing to do after defining problems would be running the analysis
# but now we are only interested in stiffness matrix. We have to assemble the
# matrix using assemble!(problem, time) -function.

assemble!(problem, 0.0)

# Now we have the stiffness matrix in problem.assembly.K you may type it to
# console and see that it is in sparse matrix form. We can write it as normal
# matrix with full() -function.

K = full(problem.assembly.K)
display(K)

# This is not necessary but we can round it with round() -function.

K = round(K,2)
display(K)
