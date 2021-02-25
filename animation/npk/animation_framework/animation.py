

class Attribute(object):
    def __init__(self, data, name="", aligned_with_animation=True):
        self.name = name
        self.data = data
        self.align_with_animation = aligned_with_animation

    def __getitem__(self, item):
        return Attribute(self.data[item], name=self.name, aligned_with_animation=self.align_with_animation)


class Animation(object):
    def __init__(self, pq, name=""):
        self.pq = pq
        self.name = name
        self.attributes = []

    def __len__(self):
        return len(self.pq[0])

    def __getitem__(self, item):

        anim = Animation((self.pq[0][item, :, :], self.pq[1][item, :, :]),
                         '{}_{}'.format(self.name, item))
        for attr in self.attributes:
            if attr.align_with_animation:
                anim.attributes.append(attr[item])
            else:
                anim.attributes.append(attr[:])
        return anim

    def attribute(self, name):
        return next((attr for attr in self.attributes if attr.name == name), None)
