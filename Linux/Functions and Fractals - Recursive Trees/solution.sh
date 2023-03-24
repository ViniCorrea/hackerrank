#!/bin/bash

print_filler() {
  n=$1
  line="____________________________________________________________________________________________________"
  # prints filler lines in front of Nth tree
  # calculate the number of filler lines in front of nth tree, then print them
  sub=0
  max_height=32
  for (( i=n; i>=1; i-- )) # nth tree
  do
    sub=$(( sub + max_height ))
    max_height=$(( max_height / 2 ))
  done

  for (( i=0; i<$(( 63 - sub )); i++ )) # print lines
  do
    printf "%s\n" "$line"
  done
}

print_y() {
  n=$1
  h=$1

  line="____________________________________________________________________________________________________"

  # Note: no info given on how Ys are supposed to fit into rectangle
  # therefore, hard-coding widths/heights
  max_height=32
  max_width=50

  height=$(( max_height / 2 ** (n - 1) ))
  num_ys=$(( 2 ** (n - 1) ))
  start=$(( max_width - (max_height - height) ))

  # expand out from current_index to build branches
  expand=$(( height / 2 ))

  # loop: the height of the tree - print each line of tree
  for (( i=1; i<=height; i++ )) # lines
  do
    current_line=$line
    current_index=$start

    # loop: the number of Ys (trees) in the line
    # always start from current (start) and increment by height
    # for (( j=height; j>=1; j-- ))
    for (( j=1; j<=num_ys; j++ ))
    do
      current_line=$(printf "%s" "$current_line" | sed "s/./1/$(( current_index + expand ))")
      current_line=$(printf "%s" "$current_line" | sed "s/./1/$(( current_index - expand ))")
      current_index=$(( current_index + (height * 2) ))
    done

    # decrement expand, the branches of the tree
    if (( expand > 0 ))
    then
      expand=$(( expand - 1 ))
    fi
    printf "%s\n" "$current_line"
  done
}

# Main Program
read -r n # number of iterations
print_filler "$n"
for (( k=n; k>=1; k-- ))
do
  print_y "$k"
done
