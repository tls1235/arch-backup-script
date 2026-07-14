import java.util.ArrayList;
import java.util.List;

public class BinSearchTree<T extends Comparable<T>> {

  private class Node {
    private Node high;
    private Node low;
    private T value;

    Node(T value) {
      this.value = value;
    }
  }

  private int size = 0;
  private Node root;
  public List<T> list = new ArrayList<>();

  public void add(T value) {
    root = insert(root, value);
  }

  public int size() {
    return size;
  }

  private Node insert(Node node, T value) {
    list = new ArrayList<T>();
    if (node == null) {
      size++;
      return new Node(value);
    }
    int cmp = value.compareTo(node.value);
    if (cmp > 0) {
      node.high = insert(node.high, value);
    } else if (cmp < 0) {
      node.low = insert(node.low, value);
    }
    return node;
  }

  public boolean contains(T value) {
    return contains(root, value);
  }

  private boolean contains(Node node, T value) {
    if (node == null) {
      return false;
    }
    int cmp = value.compareTo(node.value);
    if (cmp == 0) {
      return true;
    }
    if (cmp > 0) {
      return contains(node.high, value);
    }
    if (cmp < 0) {
      return contains(node.low, value);
    }
    return false;
  }

  private Node findMin(Node node) {
    while (node.low != null) {
      node = node.low;
    }
    return node;
  }

  public void remove(T value) {
    list = new ArrayList<T>();
    root = delete(root, value);
  }

  private Node delete(Node node, T value) {
    if (node == null) {
      return null;
    }
    int cmp = value.compareTo(node.value);
    if (cmp > 0) {
      node.high = delete(node.high, value);
      return node;
    } else if (cmp < 0) {
      node.low = delete(node.low, value);
      return node;
    } else {
      size--;
    }
    if (node.high == null) {
      return node.low;
    }
    if (node.low == null) {
      return node.high;
    }
    Node replaceable = findMin(node.high);
    node.value = replaceable.value;
    node.high = delete(node.high, replaceable.value);
    size++;
    return node;
  }

  public List<T> sort() {
    list = new ArrayList<T>();
    inOrder(root, list);
    return list;
  }

  private void inOrder(Node node, List<T> result) {
    if (node == null)
      return;
    inOrder(node.low, result);
    result.add(node.value);
    inOrder(node.high, result);
  }

  public void reBuild() {
    sort();
    root = reBuild(list);
  }

  private Node reBuild(List<T> list) {
    if (list.isEmpty()) {
      return null;
    }
    int mid = list.size() / 2;
    Node node = new Node(list.get(mid));
    node.low = reBuild(list.subList(0, mid));
    node.high = reBuild(list.subList(mid + 1, list.size()));
    return node;
  }
}
