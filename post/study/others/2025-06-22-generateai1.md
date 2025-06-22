---
layout: default
title: "generateai1"
date: 2025-06-22
use_mathjax: true
# categories:
---

# 生成AIを使ったプログラミング(1)

生成AIの用途の一つにプログラミングの学習がある。ここでは、生成AIを用いて色々とデモを作成することで、「モノ」を効率的に作成する方法を模索し、試したことをメモしていく。
初回はソートアルゴリズムのデモを作成する。
今回のデモを作成するにあたり、以下の流れを取った。

1. ChatGPTを用いて指示を英訳してもらう。
2. Gemini 2.5 Flashを用いて、英訳した指示を入力する。
3. 生成されたコードを実行する。

ここで、コード生成にGemini 2.5 Flashを使用したのは、APIキーを無料枠で一定の分量使用できたため。Geminiの無料枠でのAPIキーの使用料詳細は[レート制限](https://ai.google.dev/gemini-api/docs/rate-limits?hl=ja#how-to-upgrade--to-the-next-tier)に書かれてある。特に、Gemini 2.5 Flashに関しては

- 1 分あたりのリクエスト数：10
- 1 日あたりのリクエスト数：250
- 1 分あたりのトークン数（入力）：250,000

とある. デモとして色々と触れるには良さそう。ただし、

> 指定されたレートの上限は保証されず、実際の容量は変動する可能性があります

とあるため、今後の動向には注意が必要。今回はAPIキーを用いて、以下の通り入力を行った。

```python
from google import genai
from dotenv import load_dotenv
import os

load_dotenv()
google_api_key = os.getenv("GOOGLE_API_KEY")
client = genai.Client(api_key=google_api_key)

prompt = """
You are someone who is well-versed in programming. 
Please provide three different programs that sort a list of ten randomly given numbers. 
Each program must use a different sorting algorithm. 
Also, ensure that the sorting process can be visualized through animation.
Use the language as Python.
Do not use the package Tkinter.
"""

response = client.models.generate_content(
    model="gemini-2.5-flash",
    contents=prompt
)

print(response.text)
```

結果は以下の通り。

You're looking for Python programs to visualize sorting algorithms without using
`Tkinter`. This is a fantastic challenge, and `matplotlib` is an excellent choice for this kind of animation!

Here are three Python programs, each demonstrating a different sorting algorithm (Bubble Sort, Insertion Sort, and Selection Sort) with a real-time bar chart animation using `matplotlib`.

**Before you run:**

Make sure you have `matplotlib` installed. If not, open your terminal or command prompt and run:

```bash
pip install matplotlib
```


### Visualization Approach

All three programs use a common `matplotlib` based animation strategy:
1.  **Interactive Mode**: `plt.ion()` puts `matplotlib` in interactive mode, allowing plots to be updated without blocking execution.
2.  **Dynamic Bar Chart**: A bar chart represents the list. The height of each bar corresponds to the value of the number.
3.  **Color Coding**:
    *   **Skyblue**: Default color for bars.
    *   **Red**: Highlights elements currently being compared or involved in a potential swap.
    *   **Purple**: Highlights a "key" element (e.g., the element being inserted in Insertion Sort, or the current position being filled in Selection Sort).
    *   **Green**: Marks elements that are already in their final sorted position.
4.  **Real-time Updates**: In each step of the sorting algorithm, `ax.clear()` clears the previous plot, `ax.bar()` draws the new state with updated colors, and `fig.canvas.draw()` followed by `fig.canvas.flush_events()` redraws the canvas. `time.sleep()` introduces a small delay to make the animation visible.
5.  **Final Plot**: After sorting, `plt.ioff()` turns off interactive mode and `plt.show()` keeps the final sorted plot displayed until you close it.

Let's dive into the programs!


### Program 1: Bubble Sort Visualization

**Algorithm Explanation**:
Bubble Sort repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order. The pass through the list is repeated until no swaps are needed, which indicates that the list is sorted. Larger elements "bubble" to the end of the list with each pass.

**How Visualization Works**:
*   Red bars show the two elements currently being compared.
*   Green bars accumulate from the right, representing elements that have "bubbled" to their final sorted position.

```python
# bubble_sort_visualization.py

import matplotlib.pyplot as plt
import random
import time

# --- Matplotlib Setup for Animation ---
plt.ion() # Turn on interactive mode for live updates
fig, ax = plt.subplots(figsize=(8, 6)) # Create a figure and a set of subplots

def update_plot(arr, title, highlight_indices=None, sorted_elements_count=0):
    """
    Updates the bar chart visualization.

    Args:
        arr (list): The current state of the list.
        title (str): Title for the plot.
        highlight_indices (list, optional): Indices of elements to highlight in red.
        sorted_elements_count (int): Number of elements from the end that are sorted (green).
    """
    ax.clear() # Clear the previous plot content
    
    colors = ['skyblue'] * len(arr) # Default color for all bars
    
    # Mark elements that are already sorted (green)
    for i in range(len(arr) - 1, len(arr) - 1 - sorted_elements_count, -1):
        colors[i] = 'green'
            
    # Highlight active elements (red) for comparison/swapping
    if highlight_indices:
        for idx in highlight_indices:
            if idx < len(arr): # Ensure index is valid
                colors[idx] = 'red'

    # Draw the bars with updated heights and colors
    ax.bar(range(len(arr)), arr, color=colors)
    
    ax.set_title(title)
    ax.set_xlabel("Index")
    ax.set_ylabel("Value")
    # Set y-limit slightly above max value for better scaling
    ax.set_ylim(0, max(arr) * 1.1 if arr else 100) 
    ax.set_xticks(range(len(arr))) # Ensure all x-axis ticks are visible

    # Redraw the canvas and process events
    fig.canvas.draw()
    fig.canvas.flush_events()
    time.sleep(0.3) # Pause for animation effect

# --- Bubble Sort Algorithm with Animation ---
def bubble_sort_animated(arr):
    """
    Sorts a list using Bubble Sort and visualizes the process.
    """
    n = len(arr)
    
    # Outer loop for passes (n-1 passes needed)
    for i in range(n - 1):
        # Inner loop for comparisons and swaps
        # Last 'i' elements are already in place
        for j in range(n - 1 - i):
            # Visualize comparison of arr[j] and arr[j+1]
            update_plot(arr, f"Bubble Sort: Pass {i+1} - Comparing {arr[j]} & {arr[j+1]}", 
                        highlight_indices=[j, j+1], sorted_elements_count=i)
            
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
                # Visualize the swap
                update_plot(arr, f"Bubble Sort: Swapped {arr[j+1]} & {arr[j]}", 
                            highlight_indices=[j, j+1], sorted_elements_count=i)
        
        # After each pass, the largest unsorted element is in its correct place
        update_plot(arr, f"Bubble Sort: Pass {i+1} Completed. Element {arr[n-1-i]} sorted.", 
                    sorted_elements_count=i+1)

    # Final state: all elements are sorted
    update_plot(arr, "Bubble Sort: Sorting Complete!", sorted_elements_count=n)

# --- Main Execution ---
if __name__ == "__main__":
    # Generate a list of 10 random numbers between 1 and 100
    initial_list = random.sample(range(1, 101), 10) 
    print("Initial list:", initial_list)
    
    list_to_sort = list(initial_list) # Create a copy to preserve original
    
    # Run the animated bubble sort
    bubble_sort_animated(list_to_sort)
    
    print("Sorted list:", list_to_sort)
    
    plt.ioff() # Turn off interactive mode before showing final plot
    plt.show() # Keep the final plot window open until manually closed
```


### Program 2: Insertion Sort Visualization

**Algorithm Explanation**:
Insertion Sort builds the final sorted list one item at a time. It iterates through the input list and removes one element, finding its correct position in the sorted part of the list, and inserting it there. This process is repeated until no input elements remain. It's similar to how one might sort a hand of playing cards.

**How Visualization Works**:
*   The `purple` bar represents the "key" element that is currently being inserted into its correct position in the sorted part.
*   `Red` bars show elements in the sorted partition that are being shifted to make space for the `key`.
*   `Green` bars accumulate from the left, representing the growing sorted portion of the list.

```python
# insertion_sort_visualization.py

import matplotlib.pyplot as plt
import random
import time

# --- Matplotlib Setup for Animation ---
plt.ion() # Turn on interactive mode for live updates
fig, ax = plt.subplots(figsize=(8, 6)) # Create a figure and a set of subplots

def update_plot(arr, title, highlight_indices=None, current_element_idx=None, sorted_partition_end_idx=None):
    """
    Updates the bar chart visualization for Insertion Sort.

    Args:
        arr (list): The current state of the list.
        title (str): Title for the plot.
        highlight_indices (list, optional): Indices of elements to highlight in red (e.g., shifted elements).
        current_element_idx (int, optional): Index of the key element currently being inserted (purple).
        sorted_partition_end_idx (int, optional): The last index of the sorted partition (green).
    """
    ax.clear() # Clear the previous plot content
    
    colors = ['skyblue'] * len(arr) # Default color for all bars
    
    # Mark the sorted partition (green)
    if sorted_partition_end_idx is not None:
        for i in range(sorted_partition_end_idx + 1):
            colors[i] = 'green'
            
    # Highlight active elements (red) that are being shifted
    if highlight_indices:
        for idx in highlight_indices:
            if idx < len(arr):
                colors[idx] = 'red'
            
    # Highlight the current element being inserted (purple)
    if current_element_idx is not None:
        if current_element_idx < len(arr):
            colors[current_element_idx] = 'purple'

    # Draw the bars
    ax.bar(range(len(arr)), arr, color=colors)
    
    ax.set_title(title)
    ax.set_xlabel("Index")
    ax.set_ylabel("Value")
    ax.set_ylim(0, max(arr) * 1.1 if arr else 100) 
    ax.set_xticks(range(len(arr)))

    fig.canvas.draw()
    fig.canvas.flush_events()
    time.sleep(0.3) # Pause for animation effect

# --- Insertion Sort Algorithm with Animation ---
def insertion_sort_animated(arr):
    """
    Sorts a list using Insertion Sort and visualizes the process.
    """
    n = len(arr)
    
    # Initial state: the first element is considered sorted
    update_plot(arr, "Insertion Sort: Initial State", sorted_partition_end_idx=0) 

    # Iterate from the second element
    for i in range(1, n):
        key = arr[i] # Element to be inserted
        j = i - 1    # Last element of the sorted partition
        
        # Highlight the key element that we are about to insert
        update_plot(arr, f"Insertion Sort: Current element to insert: {key}", 
                    current_element_idx=i, sorted_partition_end_idx=i-1)

        # Move elements of arr[0..i-1], that are greater than key,
        # to one position ahead of their current position
        while j >= 0 and key < arr[j]:
            # Visualize the shift operation
            update_plot(arr, f"Insertion Sort: Shifting {arr[j]}", 
                        highlight_indices=[j, j+1], current_element_idx=i, 
                        sorted_partition_end_idx=i-1)
            arr[j + 1] = arr[j]
            j -= 1
        
        arr[j + 1] = key # Place the key in its correct position
        
        # Show the list after inserting the key
        update_plot(arr, f"Insertion Sort: Inserted {key} into position {j+1}", 
                    current_element_idx=j+1, sorted_partition_end_idx=i)
        
    # Final state: all elements are sorted
    update_plot(arr, "Insertion Sort: Sorting Complete!", sorted_partition_end_idx=n-1)

# --- Main Execution ---
if __name__ == "__main__":
    initial_list = random.sample(range(1, 101), 10) 
    print("Initial list:", initial_list)
    
    list_to_sort = list(initial_list)
    
    insertion_sort_animated(list_to_sort)
    
    print("Sorted list:", list_to_sort)
    
    plt.ioff() 
    plt.show()
```


### Program 3: Selection Sort Visualization

**Algorithm Explanation**:
Selection Sort divides the input list into two parts: a sorted part at the beginning and an unsorted part at the end. It repeatedly finds the minimum element from the unsorted part and swaps it with the first element of the unsorted part.

**How Visualization Works**:
*   The `purple` bar marks the `current_idx`, which is the position we are trying to fill with the correct smallest element.
*   The `red` bar indicates `min_idx`, the current minimum element found so far in the unsorted portion.
*   `Green` bars accumulate from the left, showing elements that have been correctly placed at the beginning of the list.

```python
# selection_sort_visualization.py

import matplotlib.pyplot as plt
import random
import time

# --- Matplotlib Setup for Animation ---
plt.ion() # Turn on interactive mode for live updates
fig, ax = plt.subplots(figsize=(8, 6)) # Create a figure and a set of subplots

def update_plot(arr, title, current_idx=None, min_idx=None, sorted_elements_count=0):
    """
    Updates the bar chart visualization for Selection Sort.

    Args:
        arr (list): The current state of the list.
        title (str): Title for the plot.
        current_idx (int, optional): Index of the element whose final position is being determined (purple).
        min_idx (int, optional): Index of the minimum element found so far in the unsorted part (red).
        sorted_elements_count (int): Number of elements at the beginning that are sorted (green).
    """
    ax.clear() # Clear the previous plot content
    
    colors = ['skyblue'] * len(arr) # Default color for all bars
    
    # Mark elements that are already sorted (green)
    for i in range(sorted_elements_count):
        colors[i] = 'green'
            
    # Highlight the current position we are processing (purple)
    if current_idx is not None:
        if current_idx < len(arr):
            colors[current_idx] = 'purple'

    # Highlight the current minimum value found (red)
    if min_idx is not None:
        if min_idx < len(arr):
            colors[min_idx] = 'red'

    # Draw the bars
    ax.bar(range(len(arr)), arr, color=colors)
    
    ax.set_title(title)
    ax.set_xlabel("Index")
    ax.set_ylabel("Value")
    ax.set_ylim(0, max(arr) * 1.1 if arr else 100) 
    ax.set_xticks(range(len(arr)))

    fig.canvas.draw()
    fig.canvas.flush_events()
    time.sleep(0.3) # Pause for animation effect

# --- Selection Sort Algorithm with Animation ---
def selection_sort_animated(arr):
    """
    Sorts a list using Selection Sort and visualizes the process.
    """
    n = len(arr)
    
    for i in range(n):
        min_idx = i # Assume the first element of unsorted part is the minimum
        
        # Visualize the initial state for the current pass
        update_plot(arr, f"Selection Sort: Finding min for position {i}", 
                    current_idx=i, sorted_elements_count=i)

        # Iterate through the unsorted part to find the minimum element
        for j in range(i + 1, n):
            # Visualize comparison
            update_plot(arr, f"Selection Sort: Comparing {arr[j]} with current min {arr[min_idx]}", 
                        current_idx=j, min_idx=min_idx, sorted_elements_count=i)
            
            if arr[j] < arr[min_idx]:
                min_idx = j # Update min_idx if a smaller element is found
                # Visualize new minimum found
                update_plot(arr, f"Selection Sort: New min found at index {min_idx} (value {arr[min_idx]})", 
                            current_idx=j, min_idx=min_idx, sorted_elements_count=i)
        
        # Swap the found minimum element with the first element of the unsorted part
        if min_idx != i:
            arr[i], arr[min_idx] = arr[min_idx], arr[i]
            # Visualize the swap
            update_plot(arr, f"Selection Sort: Swapping {arr[i]} and {arr[min_idx]}", 
                        current_idx=i, min_idx=min_idx, sorted_elements_count=i)
        else:
            # If element at current_idx is already the minimum, just show it
             update_plot(arr, f"Selection Sort: Element {arr[i]} already in place at {i}.", 
                        current_idx=i, min_idx=min_idx, sorted_elements_count=i)
        
        # After each pass, one element is in its correct place at the beginning
        update_plot(arr, f"Selection Sort: Position {i} sorted. Value: {arr[i]}", 
                    sorted_elements_count=i+1)
        
    # Final state: all elements are sorted
    update_plot(arr, "Selection Sort: Sorting Complete!", sorted_elements_count=n)

# --- Main Execution ---
if __name__ == "__main__":
    initial_list = random.sample(range(1, 101), 10) 
    print("Initial list:", initial_list)
    
    list_to_sort = list(initial_list)
    
    selection_sort_animated(list_to_sort)
    
    print("Sorted list:", list_to_sort)
    
    plt.ioff() 
    plt.show()
```


### How to Run Each Program:

1.  Save each code block into a separate Python file (e.g., `bubble_sort_visualization.py`, `insertion_sort_visualization.py`, `selection_sort_visualization.py`).
2.  Open your terminal or command prompt.
3.  Navigate to the directory where you saved the files.
4.  Run each program using the `python` command:
    ```bash
    python bubble_sort_visualization.py
    python insertion_sort_visualization.py
    python selection_sort_visualization.py
    ```

You will see a `matplotlib` window pop up, showing the bar chart sorting the 10 random numbers step-by-step!

以下、このデモに関するメモ書き。
- ドキュメント含め生成されているのはすごい。
- 今回は最低限の入力にとどめたが、APIキーを介しているので、以下の機能を追加したい。
    - `.py`ファイルそのものを出力させ、生成された直後に実行できるようにする。
    - 今回ソート対象はランダムに生成した10個の整数にfixしているが、ここの入力を都度できるようにする。
    - オブジェクト指向を意識したコードに書き直す（保守・拡張性を高めるため、適切にファイルを分割する）。
- 今回はpythonで作成したが、Rustでも同様のことを試してみたい。